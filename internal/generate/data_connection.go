package generate

import (
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type connectionData struct {
	commonData
	ID         string
	Name       string
	Properties []connectionDataProperty
}

type connectionDataProperty struct {
	DisplayName *string
	Name        string
	Type        string
	Description *string
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
			if connector.AccountConfigView != nil && connector.AccountConfigView.Items != nil {
				for _, accountConfigViewItem := range connector.AccountConfigView.Items {
					if accountConfigViewItem.PropertyName != nil {

						propertyType := "string"
						if v := connector.Properties[*accountConfigViewItem.PropertyName].Type; v != nil {
							propertyType = *v
						}

						switch propertyType {
						case "boolean":
							propertyType = "bool"
						}

						connectionProperties = append(connectionProperties, connectionDataProperty{
							DisplayName: connector.Properties[*accountConfigViewItem.PropertyName].DisplayName,
							Name:        *accountConfigViewItem.PropertyName,
							Type:        propertyType,
							Description: connector.Properties[*accountConfigViewItem.PropertyName].Info,
						})
					}
				}
			}
			break
		}
	}

	return connectionProperties, nil
}
