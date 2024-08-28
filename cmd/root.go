package cmd

import (
	"fmt"
	"io"
	"log"
	"os"
	"strings"

	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/spf13/cobra"
	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

const (
	jsonFilePathParamNameLong  = "export-file-path"
	jsonFilePathParamNameShort = "e"

	configEnvPrefix = "PINGCTL_DVTF"
)

var (
	jsonFilePath []string
	jsonContents string

	configKeys = map[string]string{}
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

		err = bindParams(cmd)
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

		return nil
	},
}

func SetVersionInfo(version, commit string) {
	rootCmd.Version = fmt.Sprintf("%s (Git Commit SHA %s)", version, commit)
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

	for _, v := range generateConfigKeys {
		configKeyVal := strings.ReplaceAll(v, "-", "")
		configKeys[configKeyVal] = fmt.Sprintf("generate.%s", configKeyVal)
	}

	for _, v := range validateConfigKeys {
		configKeyVal := strings.ReplaceAll(v, "-", "")
		configKeys[configKeyVal] = fmt.Sprintf("validate.%s", configKeyVal)
	}

	// Add config flags
	rootCmd.PersistentFlags().StringSliceVarP(&jsonFilePath, jsonFilePathParamNameLong, jsonFilePathParamNameShort, []string{}, "The path to the JSON export file.  E.g. /path/to/export.json.  This parameter is not required if piping the JSON to the command.")
	if err := rootCmd.MarkPersistentFlagRequired(jsonFilePathParamNameLong); err != nil {
		l.Err(err).Msgf("Error marking flag %s as required.", jsonFilePathParamNameLong)
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

	viper.SetEnvPrefix(configEnvPrefix)

	viper.SetEnvKeyReplacer(strings.NewReplacer("-", "_"))

	viper.AutomaticEnv()

	l.Debug().Msgf("Setting configuration..")

	return nil
}

func bindParams(cmd *cobra.Command) error {
	cmd.Flags().VisitAll(func(f *pflag.Flag) {
		configName := strings.ReplaceAll(f.Name, "-", "")

		if v, ok := configKeys[configName]; ok {
			configName = v
		}

		if !f.Changed && viper.IsSet(configName) {
			// if err = cmd.Flags().SetAnnotation(f.Name, cobra.BashCompOneRequiredFlag, []string{"false"}); err != nil {
			// 	l.Err(err).Msgf("Error setting required status for flag %s", f.Name)
			// 	return
			// }
			viperValue := viper.Get(configName)
			switch v := viperValue.(type) {
			case []interface{}:
				values := make([]string, 0)
				for _, val := range v {
					values = append(values, fmt.Sprintf("%v", val))
				}
				cmd.Flags().Set(f.Name, strings.Join(values, ","))
			default:
				cmd.Flags().Set(f.Name, fmt.Sprintf("%v", v))
			}
		}
	})

	return nil
}
