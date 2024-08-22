package cmd

import (
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/patrickcping/dvtf-pingctl/internal/flow"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	generateIncludes []string
)

const (
	generateCmdName = "generate"

	generateIncludeConfigKey = "resources"
	generateIncludeParamLong = "resource"	
	generateIncludeParamShort = "r"
)

var (
	authenticationPolicyConfigurationParamMapping = map[string]string{
		generateIncludeParamLong: generateIncludeConfigKey,
	}
)

var generateCmd = &cobra.Command{
	Use:   generateCmdName,
	Short: "Generate HCL configuration from a DaVinci service JSON export file",
	Long: fmt.Sprintf(`Generate HCL configuration from a DaVinci service JSON export file.

	Only "%[6]s", "%[7]s", and "%[8]s" resources are supported.

	Resources can be selected using the --%[4]s flag (-%[5]s for short), and if this flag is omitted, all resources will be generated.

	Examples:
	
	dvtf-pingctl %[1]s --%[2]s /path/to/my/export.json
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json
	dvtf-pingctl %[1]s --%[2]s /path/to/my/export.json --%[4]s %[6]s --%[4]s %[7]s --%[4]s %[8]s
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json -%[5]s %[6]s -%[5]s %[7]s -%[5]s %[8]s
	cat /path/to/my/export.json | dvtf-pingctl generate --%[4]s %[6]s
	cat /path/to/my/export.json | dvtf-pingctl generate -%[5]s %[6]s
	
	`, generateCmdName, jsonFilePathParamNameLong, jsonFilePathParamNameShort, generateIncludeParamLong, generateIncludeParamShort, terraform.ProviderResourceTypeFlow, terraform.ProviderResourceTypeVariable, terraform.ProviderResourceTypeConnection),
	Run: func(cmd *cobra.Command, args []string) {
		l := logger.Get()
		l.Debug().Msgf("Generate Command called.")

		var dvFlow *flow.DaVinciExport
		var err error

		if jsonContents != "" {

			dvFlow, err = flow.NewFromPipe(string(jsonContents))
			if err != nil {
				log.Fatal(err)
			}

		} else {
			
			dvFlow, err = flow.NewFromPath(viper.GetString(jsonFilePathConfigKey))
			if err != nil {
				log.Fatal(err)
			}
		}

		resources := make([]terraform.ProviderResource, 0)
		for _, r := range generateIncludes {
			resources = append(resources, terraform.ProviderResource(r))
		}

		//todo: make param
		version := "0.4"

		ok, err := dvFlow.Generate(resources, version)
		if err != nil {
			log.Fatal(err)
		}

		if !ok {
			os.Exit(1)
		}

		os.Exit(0)
	},
}

func init() {
	l := logger.Get()

	generateCmd.PersistentFlags().StringSliceVar(&generateIncludes, generateIncludeConfigKey, terraform.AllowedProviderResources, fmt.Sprintf("The list of resource types to generate configuration for.  Case sensitive.  If left undefined, all resources will be generated.  Options are %s", strings.Join(terraform.AllowedProviderResources, ", ")))

	if err := bindParams(authenticationPolicyConfigurationParamMapping, generateCmd); err != nil {
		l.Err(err).Msgf("Error binding parameters: %s", err)
	}
}
