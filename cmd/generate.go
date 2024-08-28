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
	generateIncludes        []string
	generateOutputPath      string
	overwriteGeneratedFiles bool

	generateIncludeParamDefault = terraform.AllowedProviderResources

	generateConfigKeys = []string{
		generateIncludeParamLong,
		generateOutputPathParamLong,
		overwriteParamLong,
	}
)

const (
	generateCmdName = "generate"

	generateIncludeParamLong  = "resource"
	generateIncludeParamShort = "r"

	generateOutputPathParamLong    = "output-path"
	generateOutputPathParamShort   = "o"
	generateOutputPathParamDefault = "./"

	overwriteParamLong    = "overwrite"
	overwriteParamDefault = false
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
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json --%[9]s /path/to/my/output/dir/
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json -%[10]s /path/to/my/output/dir/
	dvtf-pingctl %[1]s -%[3]s /path/to/my/export.json -%[10]s /path/to/my/output/dir/ --overwrite

	JSON input can be piped in, which replaces the need for the --%[2]s / -%[3]s parameter:

	cat /path/to/my/export.json | dvtf-pingctl generate --%[4]s %[6]s
	cat /path/to/my/export.json | dvtf-pingctl generate -%[5]s %[6]s
	cat /path/to/my/export.json | dvtf-pingctl generate --%[9]s /path/to/my/output/dir/
	cat /path/to/my/export.json | dvtf-pingctl generate -%[10]s /path/to/my/output/dir/
	cat /path/to/my/export.json | dvtf-pingctl generate -%[10]s /path/to/my/output/dir/ --overwrite
	
	`, generateCmdName, jsonFilePathParamNameLong, jsonFilePathParamNameShort, generateIncludeParamLong, generateIncludeParamShort, terraform.ProviderResourceTypeFlow, terraform.ProviderResourceTypeVariable, terraform.ProviderResourceTypeConnection, generateOutputPathParamLong, generateOutputPathParamShort),
	Run: func(cmd *cobra.Command, args []string) {
		l := logger.Get()
		l.Debug().Msgf("Generate Command called.")

		var dvFlow flow.DaVinciExportIntf
		var err error

		if jsonContents != "" {

			output.Print(output.Opts{
				Message: fmt.Sprintf("Generating HCL to %s, overwrite %v", generateOutputPath, overwriteGeneratedFiles),
			})

			dvFlow, err = flow.NewFromPipe(string(jsonContents))
			if err != nil {
				log.Fatal(err)
			}

		} else {

			output.Print(output.Opts{
				Message: fmt.Sprintf("Generating HCL from JSON at %s to %s, overwrite %v", jsonFilePath, generateOutputPath, overwriteGeneratedFiles),
			})

			dvFlow, err = flow.NewFromPaths(jsonFilePath)
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

		ok, err := dvFlow.Generate(resources, version, generateOutputPath, overwriteGeneratedFiles)
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

	generateCmd.PersistentFlags().StringSliceVarP(&generateIncludes, generateIncludeParamLong, generateIncludeParamShort, generateIncludeParamDefault, fmt.Sprintf("The list of resource types to generate configuration for.  Case sensitive.  If left undefined, all resources will be generated.  Options are %s", strings.Join(terraform.AllowedProviderResources, ", ")))

	generateCmd.PersistentFlags().StringVarP(&generateOutputPath, generateOutputPathParamLong, generateOutputPathParamShort, generateOutputPathParamDefault, "The directory path to which generated files will be saved.  E.g. /path/to/my/output/.")
	if err := rootCmd.MarkPersistentFlagRequired(generateOutputPathParamLong); err != nil {
		l.Err(err).Msgf("Error marking flag %s as required.", generateOutputPathParamLong)
	}

	generateCmd.PersistentFlags().BoolVar(&overwriteGeneratedFiles, overwriteParamLong, overwriteParamDefault, "Instructs the generator to overwrite previously generated files.")
}
