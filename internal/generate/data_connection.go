package generate

import (
	"slices"
	"strings"

	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type connectionData struct {
	commonData
	ID         string
	Name       string
	Properties []connectionDataProperty
}

type connectionDataProperty struct {
	DisplayName   *string
	Name          string
	ProviderType  string
	TerraformType string
	Description   *string
}

func getConnectionProperties(connectorID string) ([]connectionDataProperty, error) {
	connectionProperties := make([]connectionDataProperty, 0)

	connectorSchema := []davinci.Connector{}
	err := davinci.Unmarshal(connectorSchemaBytes, &connectorSchema, davinci.ExportCmpOpts{
		IgnoreEnvironmentMetadata: true,
	})
	if err != nil {
		return nil, err
	}

	for _, connector := range connectorSchema {
		if *connector.ConnectorID == connectorID {
			if connector.Properties != nil {
				for propertyName, property := range connector.Properties {
					propertyType := "string"
					if v := property.Type; v != nil {
						propertyType = *v
					}

					terraformType, providerType := getConnectorGeneratorTypes(propertyType)

					connectionProperties = append(connectionProperties, connectionDataProperty{
						DisplayName:   property.DisplayName,
						Name:          propertyName,
						ProviderType:  providerType,
						TerraformType: terraformType,
						Description:   property.Info,
					})
				}
			}
			break
		}
	}

	slices.SortFunc(connectionProperties, func(i, j connectionDataProperty) int {
		return strings.Compare(i.Name, j.Name)
	})

	return connectionProperties, nil
}

func getConnectorGeneratorTypes(dvSchemaPropertyType string) (terraformType string, providerType string) {
	switch dvSchemaPropertyType {
	case "boolean":
		return "bool", "boolean"
	case "string":
		return "string", "string"
	case "number":
		return "number", "number"
	case "object":
		return "object", "json"
	case "array":
		return "list", "json"
	default:
		return "string", "string"
	}
}
