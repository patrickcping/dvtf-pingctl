package cmd

import (
	"fmt"
	"io"
	"log"
	"os"

	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/spf13/cobra"
	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

var (
	// these will be set by the goreleaser configuration
	// to appropriate values for the compiled binary
	version string = "dev"

	// goreleaser can also pass the specific commit if you want
	commit string = ""
)

const (
	jsonFilePathConfigKey = "jsonFilePath"
	jsonFilePathParamNameLong = "export-file-path"	
	jsonFilePathParamNameShort = "e"
)

var (
	jsonFilePath string
	jsonContents string

	rootConfigurationParamMapping = map[string]string{
		jsonFilePathParamNameLong:              jsonFilePathConfigKey,
	}
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "dvtf-pingctl",
	Short: "dvtf-pingctl is a CLI utility to assist with using the Ping Identity DaVinci Terraform provider.",
	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		l := logger.Get()

		err := initConfig()
		if err != nil {
			return err
		}

		stat, _ := os.Stdin.Stat()
		if (stat.Mode() & os.ModeCharDevice) == 0 {
			// Read the input
			input, err := io.ReadAll(os.Stdin)
			if err != nil {
				log.Fatal("Error reading input:", err)
			}

			jsonContents = string(input)

			if err = cmd.Flags().SetAnnotation(jsonFilePathParamNameLong, cobra.BashCompOneRequiredFlag, []string{"false"}); err != nil {
				l.Err(err).Msgf("Error setting required status for flag %s", jsonFilePathParamNameLong)
				return err
			}
		}

		cmd.Flags().VisitAll(func(f *pflag.Flag) {
			if v, ok := rootConfigurationParamMapping[f.Name]; ok && viper.IsSet(v) {
				if err = cmd.Flags().SetAnnotation(f.Name, cobra.BashCompOneRequiredFlag, []string{"false"}); err != nil {
					l.Err(err).Msgf("Error setting required status for flag %s", f.Name)
					return
				}
			}
		})

		return nil
	},
	Version: fmt.Sprintf("%s-%s", version, commit),
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	l := logger.Get()

	// General function commands
	rootCmd.AddCommand(
		generateCmd,
		validateCmd,
	)

	// Add config flags
	rootCmd.PersistentFlags().StringVarP(&jsonFilePath, jsonFilePathParamNameLong, jsonFilePathParamNameShort, viper.GetString("DVTF_EXPORT_FILE_PATH"), "The path to the JSON export file.  E.g. /path/to/export.json")
	if err := rootCmd.MarkPersistentFlagRequired(jsonFilePathParamNameLong); err != nil {
		l.Err(err).Msgf("Error marking flag %s as required.", jsonFilePathParamNameLong)
	}
	
	if err := bindParams(rootConfigurationParamMapping, rootCmd); err != nil {
		l.Err(err).Msgf("Error binding parameters: %s", err)
	}
}

func initConfig() error {
	l := logger.Get()

	l.Debug().Msgf("Initialising configuration..")

	viper.SetConfigName(".dvtf-pingctl")
	viper.SetConfigType("yaml")
	viper.AddConfigPath(".")

	l.Debug().Msgf("Reading configuration..")
	if err := viper.ReadInConfig(); err != nil {
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			l.Err(err).Msgf("Error reading configuration file.")
			return err
		}
	}

	viper.SetEnvPrefix("DVTF")

	viper.AutomaticEnv()

	l.Debug().Msgf("Setting configuration..")

	return nil
}

func bindParams(paramlist map[string]string, command *cobra.Command) error {
	// Do the binds
	for k, v := range paramlist {
		err := viper.BindPFlag(v, command.PersistentFlags().Lookup(k))
		if err != nil {
			return err
		}
	}

	return nil
}
