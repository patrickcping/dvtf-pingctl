package generate

import (
	"encoding/json"
	"strings"
)

type variableData struct {
	commonData
	Context       string
	FlowIDRef     *string
	Name          string
	ProviderType  string
	TerraformType string
	Sensitive     bool
	Description   *string
	Value         *variableDataValue
	Min           *int32
	Max           *int32
	Mutable       *bool
}

type variableDataValue struct {
	JSON   *string
	Text   *string
	Bool   *bool
	Number *float32
}

func parseFieldValue(value interface{}) *variableDataValue {
	variableDataValue := &variableDataValue{} // Initialize the variableDataValue

	switch v := value.(type) {
	case string:
		if (strings.HasPrefix(v, "{") || strings.HasPrefix(v, "[")) && json.Valid([]byte(v)) {
			variableDataValue.JSON = &v
		} else {
			sanistisedV := sanitiseStringField(v)

			if sanistisedV == "" {
				return nil
			} else {
				variableDataValue.Text = &sanistisedV
			}
		}
	case bool:
		variableDataValue.Bool = &v
	case float32:
		variableDataValue.Number = &v
	case int32:
		parsedNumber := float32(v)
		variableDataValue.Number = &parsedNumber
	case int64:
		parsedNumber := float32(v)
		variableDataValue.Number = &parsedNumber
	case int:
		parsedNumber := float32(v)
		variableDataValue.Number = &parsedNumber
	}

	return variableDataValue
}

func getVariableGeneratorTypes(dvVariableType string) (terraformType string, providerType string, sensitive bool) {
	switch dvVariableType {
	case "boolean":
		return "bool", "boolean", false
	case "string":
		return "string", "string", false
	case "number":
		return "number", "number", false
	case "object":
		return "any", "object", false
	case "secret":
		return "string", "secret", true
	default:
		return "string", "string", false
	}
}
