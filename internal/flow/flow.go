package flow

import (
	"errors"
	"io"
	"os"

	"github.com/patrickcping/dvtf-pingctl/internal/generate"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
	"github.com/patrickcping/dvtf-pingctl/internal/validate"
)

type DaVinciExport struct {
	exportPath  *string
	ExportBytes []byte
}

func NewFromPath(pathToJson string) (*DaVinciExport, error) {
	dvExport := DaVinciExport{
		exportPath: &pathToJson,
	}

	// Get the string from file
	dvExport.readJSONFile()

	return &dvExport, nil
}

func NewFromPipe(exportString string) (*DaVinciExport, error) {
	dvExport := DaVinciExport{
		ExportBytes: []byte(exportString),
	}

	return &dvExport, nil
}

func (d *DaVinciExport) Generate(resources []terraform.ProviderResource, version string) (ok bool, err error) {
	generate := generate.New(d.ExportBytes, resources)

	if d.exportPath != nil {
		generate.SetPath(*d.exportPath)
	}

	return true, generate.Generate(version)
}

func (d *DaVinciExport) Validate(providerField terraform.ProviderField) (ok bool, err error) {
	validator := validate.New(d.ExportBytes, providerField)

	return validator.OutputValidationResponse(validator.Validate())
}

// Read the text from the file
func (d *DaVinciExport) readJSONFile() error {

	if d.exportPath == nil {
		return errors.New("No export path provided")
	}

	// Open the JSON file
	file, err := os.Open(*d.exportPath)
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
