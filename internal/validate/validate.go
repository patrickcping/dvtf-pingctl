package validate

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"strings"

	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/output"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

var (
	// Replicated from https://github.com/pingidentity/terraform-provider-davinci/blob/007d4dd02f01438b0f28feee44ad03b6325e3263/internal/service/davinci/resource_flow.go#L77-L90
	flowJsonCmpOptsConfiguration = davinci.ExportCmpOpts{
		IgnoreConfig:              false,
		IgnoreDesignerCues:        false,
		IgnoreEnvironmentMetadata: true,
		IgnoreUnmappedProperties:  false,
		IgnoreVersionMetadata:     true,
		IgnoreFlowMetadata:        false,
		IgnoreFlowVariables:       false,
		NodeOpts: &davinci.ExportNodeCmpOpts{
			VariablesConnector: &davinci.ExportNodeVariablesCmpOpts{
				ExpectVariableValues: true, // The input field needs validation
			},
		},
	}

	// Replicated from https://github.com/pingidentity/terraform-provider-davinci/blob/007d4dd02f01438b0f28feee44ad03b6325e3263/internal/service/davinci/resource_flow.go#L92-L105
	flowConfigurationJsonCmpOptsConfiguration = davinci.ExportCmpOpts{
		IgnoreConfig:              false,
		IgnoreDesignerCues:        false,
		IgnoreEnvironmentMetadata: true,
		IgnoreUnmappedProperties:  false,
		IgnoreVersionMetadata:     true,
		IgnoreFlowMetadata:        true,
		IgnoreFlowVariables:       true,
		NodeOpts: &davinci.ExportNodeCmpOpts{
			VariablesConnector: &davinci.ExportNodeVariablesCmpOpts{
				ExpectVariableValues: false, // We don't need to validate this
			},
		},
	}

	// Replicated from https://github.com/pingidentity/terraform-provider-davinci/blob/007d4dd02f01438b0f28feee44ad03b6325e3263/internal/service/davinci/resource_flow.go#L107-L120
	flowExportJsonCmpOptsConfiguration = davinci.ExportCmpOpts{
		IgnoreConfig:              false,
		IgnoreDesignerCues:        false,
		IgnoreEnvironmentMetadata: false,
		IgnoreUnmappedProperties:  true, // because we don't do calculation with this object
		IgnoreVersionMetadata:     false,
		IgnoreFlowMetadata:        false,
		IgnoreFlowVariables:       true, // because this is handled by another resource
		NodeOpts: &davinci.ExportNodeCmpOpts{
			VariablesConnector: &davinci.ExportNodeVariablesCmpOpts{
				ExpectVariableValues: false, // We don't need to validate this
			},
		},
	}
)

type DaVinciValidator struct {
	exportBytes   []byte
	providerField terraform.ProviderField
}

func New(exportBytes []byte, providerField terraform.ProviderField) *DaVinciValidator {
	l := logger.Get()
	l.Debug().Msgf("validate.New called")
	return &DaVinciValidator{
		exportBytes:   exportBytes,
		providerField: providerField,
	}
}

func (d *DaVinciValidator) Validate() error {
	l := logger.Get()
	l.Debug().Msgf("DaVinciValidator Validate called")

	switch d.providerField {
	case terraform.ProviderFieldTypeFlowJson:
		return d.terraformCustomTypeValidator(flowJsonCmpOptsConfiguration)
	case terraform.ProviderFieldTypeFlowConfigurationJson:
		return d.terraformCustomTypeValidator(flowConfigurationJsonCmpOptsConfiguration)
	case terraform.ProviderFieldTypeFlowExportJson:
		return d.terraformCustomTypeValidator(flowExportJsonCmpOptsConfiguration)
	}

	return errors.New("Invalid field type")
}

var ErrSubflowsPresent = errors.New("Subflows are present in the export.  Subflows should be managed separately as their own independent flows.")

// Replicated from the Terraform provider https://github.com/pingidentity/terraform-provider-davinci/blob/007d4dd02f01438b0f28feee44ad03b6325e3263/internal/framework/customtypes/davinciexporttype/parsed_value.go#L96
func (d *DaVinciValidator) terraformCustomTypeValidator(fieldOpts davinci.ExportCmpOpts) error {
	l := logger.Get()
	l.Debug().Msgf("DaVinciValidator terraformCustomTypeValidator called")

	var flows davinci.Flows

	l.Debug().Msgf("Multi-flow validation check")
	// should really use the actual validator
	err := davinci.Unmarshal(d.exportBytes, &flows, davinci.ExportCmpOpts{})
	if err != nil {
		l.Error().Msgf("Cannot parse flow for multi-flow validation check: %v", err)
		return err
	}

	if len(flows.Flow) > 0 {
		l.Warn().Msgf("Multi-flow validation check found a multi-flow export")
		return ErrSubflowsPresent
	}

	l.Debug().Msgf("Multi-flow validation check passed.")
	l.Debug().Msgf("Validating the config of the export without unmapped properties..")

	// Validate just the config of the export
	err = davinci.ValidFlowExport(d.exportBytes, davinci.ExportCmpOpts{
		IgnoreConfig:              fieldOpts.IgnoreConfig,
		IgnoreDesignerCues:        fieldOpts.IgnoreDesignerCues,
		IgnoreEnvironmentMetadata: fieldOpts.IgnoreEnvironmentMetadata,
		IgnoreUnmappedProperties:  true,
		IgnoreVersionMetadata:     fieldOpts.IgnoreVersionMetadata,
		IgnoreFlowMetadata:        fieldOpts.IgnoreFlowMetadata,
		IgnoreFlowVariables:       fieldOpts.IgnoreFlowVariables,
		NodeOpts:                  fieldOpts.NodeOpts,
	})

	if err != nil {
		l.Error().Msgf("Config of the export validation check failed: %v", err)
		return err
	}
	l.Debug().Msgf("Config of the export validation check passed")
	l.Debug().Msgf("Checking if there are unmapped properties in the export..")

	// Warn in case there are AdditionalProperties in the import file (since these aren't cleanly handled in the SDK, while they are preserved on import, there may be unpredictable results in diff calculation)
	err = davinci.ValidFlowExport(d.exportBytes, davinci.ExportCmpOpts{
		IgnoreConfig:              true,
		IgnoreDesignerCues:        true,
		IgnoreEnvironmentMetadata: true,
		IgnoreUnmappedProperties:  false,
		IgnoreVersionMetadata:     true,
		IgnoreFlowMetadata:        true,
		IgnoreFlowVariables:       true,
	})

	if !fieldOpts.IgnoreUnmappedProperties && err != nil {
		l.Error().Msgf("Unmapped properties check failed: %v", err)
		return err
	}
	l.Debug().Msgf("Unmapped properties check passed")

	return nil
}

func (d *DaVinciValidator) OutputValidationResponse(vErr error) (ok, warning bool, err error) {
	l := logger.Get()
	l.Debug().Msgf("DaVinciValidator OutputValidationResponse called")

	if vErr == nil {
		output.Print(output.Opts{
			Message: fmt.Sprintf("The provided flow export passes validation for the davinci_flow field %s!\n", string(d.providerField)),
			Result:  output.ENUM_RESULT_SUCCESS,
		})
		return true, false, nil
	}

	var syntaxError *json.SyntaxError
	var unmarshalTypeError *json.UnmarshalTypeError
	var equatesEmptyError *davinci.EquatesEmptyTypeError
	var missingRequiredFlowFieldsError *davinci.MissingRequiredFlowFieldsTypeError
	var unknownAdditionalFieldsError *davinci.UnknownAdditionalFieldsTypeError
	var minFlowDefsError *davinci.MinFlowDefinitionsExceededTypeError
	var maxFlowDefsError *davinci.MaxFlowDefinitionsExceededTypeError
	outputOpts := output.Opts{}
	switch {
	// Custom DV Errors
	case errors.Is(vErr, ErrSubflowsPresent):

		outputOpts = output.Opts{
			Message: "Subflows are present in the export file.  Subflows must be managed as their own independent davinci_flow resources.  Please re-export the DaVinci flow without subflows.",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, davinci.ErrInvalidJson):

		outputOpts = output.Opts{
			Message: "The DaVinci Flow Export JSON is not valid JSON.  Please re-export the DaVinci flow.",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, davinci.ErrEmptyFlow):

		outputOpts = output.Opts{
			Message: "The DaVinci Flow Export JSON is empty.  Please re-export the DaVinci flow.",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, davinci.ErrNoFlowDefinition):

		outputOpts = output.Opts{
			Message: "No flow definition found in the DaVinci Flow Export JSON.  Expecting exactly one flow definition.  Please re-export the DaVinci flow.",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, davinci.ErrMissingSaveVariableValues):

		outputOpts = output.Opts{
			Message: "Save flow variable nodes are present but are missing variable values in the DaVinci Flow Export JSON.  Please re-export the DaVinci flow ensuring that variable values are included.",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.As(vErr, &equatesEmptyError):

		outputOpts = output.Opts{
			Message: "The JSON does not appear to be a valid DaVinci export file.  Please re-export the DaVinci flow.",
			Result:  output.ENUM_RESULT_FAILURE,
			Fields: map[string]interface{}{
				"Computed Difference (empty is failure)": equatesEmptyError.Diff,
			},
		}

	case errors.As(vErr, &missingRequiredFlowFieldsError):

		outputOpts = output.Opts{
			Message: "The DaVinci Flow Export JSON has been evaluated to be missing required fields.  Please re-export the DaVinci flow.",
			Result:  output.ENUM_RESULT_FAILURE,
			Fields: map[string]interface{}{
				"Computed Difference": missingRequiredFlowFieldsError.Diff,
			},
		}

	case errors.As(vErr, &unknownAdditionalFieldsError):

		outputOpts = output.Opts{
			Message: "The DaVinci flow will be accepted by the provider, but the DaVinci Flow Export contains unknown properties that cannot be validated.  These parameters will be preserved on import to the DaVinci service, but there may be unpredictable results in difference calculation.",
			Result:  output.ENUM_RESULT_NOACTION_WARN,
			Fields: map[string]interface{}{
				"Computed Difference": unknownAdditionalFieldsError.Diff,
			},
		}

	case errors.As(vErr, &minFlowDefsError):

		outputOpts = output.Opts{
			Message: fmt.Sprintf("There are not enough flows exported in the flow group.  Expecting a minimum of %d", minFlowDefsError.Min),
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.As(vErr, &maxFlowDefsError):
		outputOpts = output.Opts{
			Message: fmt.Sprintf("There are too many flows exported in the flow group.  Expecting a maximum of %d", maxFlowDefsError.Max),
			Result:  output.ENUM_RESULT_FAILURE,
		}

	// Standard Go/JSON handling Errors
	case errors.As(vErr, &syntaxError):
		outputOpts = output.Opts{
			Message: fmt.Sprintf("The export contains badly formed JSON at position %d", syntaxError.Offset),
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, io.ErrUnexpectedEOF):
		outputOpts = output.Opts{
			Message: "The export contains badly formed JSON",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.As(vErr, &unmarshalTypeError):
		outputOpts = output.Opts{
			Message: fmt.Sprintf("The export contains an invalid value for the field %s at position %d", unmarshalTypeError.Field, unmarshalTypeError.Offset),
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case errors.Is(vErr, io.EOF):
		outputOpts = output.Opts{
			Message: "The export contents cannot be empty",
			Result:  output.ENUM_RESULT_FAILURE,
		}

	case strings.HasPrefix(vErr.Error(), "json: unknown field"):
		fieldName := strings.TrimPrefix(vErr.Error(), "json: unknown field ")
		outputOpts = output.Opts{
			Message: fmt.Sprintf("The export contains an unknown field %s", fieldName),
			Result:  output.ENUM_RESULT_FAILURE,
		}

	default:
		l.Debug().Msgf("Returning unhandled error: #%v", vErr)
		return false, false, vErr
	}

	l.Debug().Msgf("Printing output: #%v", outputOpts)

	output.Print(outputOpts)

	switch outputOpts.Result {
	case output.ENUM_RESULT_FAILURE:
		return false, false, nil
	case output.ENUM_RESULT_NOACTION_WARN:
		return true, true, nil
	default:
		return true, false, nil
	}

}
