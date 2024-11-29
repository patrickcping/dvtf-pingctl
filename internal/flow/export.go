package flow

import (
	"errors"
	"io"
	"os"

	"github.com/patrickcping/dvtf-pingctl/internal/generate"
	"github.com/patrickcping/dvtf-pingctl/internal/generate/export"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/patrickcping/dvtf-pingctl/internal/validate"
)

type DaVinciExport struct {
	ExportPath  *string
	ExportBytes []byte
}

var _ DaVinciExportIntf = &DaVinciExport{}

func NewFromPath(pathToJson string) (*DaVinciExport, error) {
	dvExport := DaVinciExport{
		ExportPath: &pathToJson,
	}

	// Get the string from file
	err := dvExport.readJSONFile()
	if err != nil {
		return nil, err
	}

	return &dvExport, nil
}

func NewFromPipe(exportString string) (*DaVinciExport, error) {
	dvExport := DaVinciExport{
		ExportBytes: []byte(exportString),
	}

	return &dvExport, nil
}

func (d *DaVinciExport) Generate(resources []terraform.ProviderResource, version, outputPath string, overwrite bool) (ok bool, err error) {
	exports := make([]export.DaVinciGeneratorExport, 0)
	exports = append(exports, export.DaVinciGeneratorExport{
		ExportBytes: d.ExportBytes,
		Path:        d.ExportPath,
	})

	generate := generate.New(exports, resources, outputPath)

	return true, generate.Generate(version, overwrite)
}

func (d *DaVinciExport) Validate(providerField terraform.ProviderField) (ok, warning bool, err error) {
	l := logger.Get()
	l.Debug().Msgf("DaVinciExport Validate called.")
	validator := validate.New(d.ExportBytes, providerField)

	l.Debug().Msgf("Validating output..")
	return validator.OutputValidationResponse(validator.Validate())
}

// Read the text from the file
func (d *DaVinciExport) readJSONFile() error {

	if d.ExportPath == nil {
		return errors.New("No export path provided")
	}

	// Open the JSON file
	file, err := os.Open(*d.ExportPath)
	if err != nil {
		return err
	}
	defer file.Close()

	// Read the file contents
	bytes, err := io.ReadAll(file)
	if err != nil {
		return err
	}

	d.ExportBytes = bytes

	return nil
}
