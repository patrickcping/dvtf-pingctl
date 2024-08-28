package cmd

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/patrickcping/dvtf-pingctl/internal/flow"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/output"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/spf13/cobra"
)

var (
	validateField string
)

const (
	validateCmdName = "validate"

	fieldParamLong  = "field"
	fieldParamShort = "f"
)

var (
	defaultParam = string(terraform.ProviderFieldTypeFlowJson)

	validateConfigKeys = []string{
		fieldParamLong,
	}
)

var validateCmd = &cobra.Command{
	Use:   validateCmdName,
	Short: "Validate the JSON export file as an input to the `davinci_flow` Terraform provider resource",
	Long: fmt.Sprintf(`Validate the JSON export file as an input to the "davinci_flow" Terraform provider resource.

	Examples:
	
	dvtf-pingctl %[1]s --%[2]s /path/to/my/export.json
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json
	cat /path/to/my/export.json | dvtf-pingctl validate

	To validate the JSON input for a specific davinci_flow field in the case of debugging state, use the --%[4]s flag (-%[5]s for short):

	dvtf-pingctl %[1]s --%[2]s /path/to/my/export.json --%[4]s %[6]s
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json -%[5]s %[6]s
	cat /path/to/my/export.json | dvtf-pingctl validate --%[4]s %[6]s
	cat /path/to/my/export.json | dvtf-pingctl validate -%[5]s %[6]s
	
	`, validateCmdName, jsonFilePathParamNameLong, jsonFilePathParamNameShort, fieldParamLong, fieldParamShort, string(terraform.ProviderFieldTypeFlowConfigurationJson)),
	Run: func(cmd *cobra.Command, args []string) {
		l := logger.Get()
		l.Debug().Msgf("validate Command called.")

		var dvFlow flow.DaVinciExportIntf
		var err error

		if jsonContents != "" {

			output.Print(output.Opts{
				Message: fmt.Sprintf("Running validation for field %s", terraform.ProviderField(validateField)),
			})

			dvFlow, err = flow.NewFromPipe(string(jsonContents))
			if err != nil {
				log.Fatal(err)
			}

		} else {

			output.Print(output.Opts{
				Message: fmt.Sprintf("Running validation for field %s for JSON at %s", terraform.ProviderField(validateField), jsonFilePath),
			})

			dvFlow, err = flow.NewFromPaths(jsonFilePath)
			if err != nil {
				log.Fatal(err)
			}
		}

		ok, warning, err := dvFlow.Validate(terraform.ProviderField(validateField))
		if err != nil {
			log.Fatal(err)
		}

		if !ok {
			os.Exit(1)
		}

		if warning {
			os.Exit(2)
		}

		os.Exit(0)
	},
}

func init() {
	validateCmd.PersistentFlags().StringVarP(&validateField, fieldParamLong, fieldParamShort, defaultParam, fmt.Sprintf("The davinci_flow field to validate the JSON input for.  Options are %s", strings.Join(terraform.AllowedProviderFields, ", ")))
}
