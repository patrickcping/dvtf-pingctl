package flow

import (
	"github.com/patrickcping/dvtf-pingctl/internal/generate"
	"github.com/patrickcping/dvtf-pingctl/internal/generate/export"
	"github.com/patrickcping/dvtf-pingctl/internal/logger"
	"github.com/patrickcping/dvtf-pingctl/internal/terraform"
)

type DaVinciExports struct {
	exports []DaVinciExport
}

var _ DaVinciExportIntf = &DaVinciExports{}

func NewFromPaths(pathToJsons []string) (*DaVinciExports, error) {
	l := logger.Get()
	l.Debug().Msgf("NewFromPaths called.")

	exports := make([]DaVinciExport, 0)
	for _, pathToJson := range pathToJsons {
		l.Debug().Msgf("Create new from single path %s", pathToJson)
		dvExport, err := NewFromPath(pathToJson)
		if err != nil {
			return nil, err
		}

		l.Debug().Msgf("Add single path to list")
		exports = append(exports, *dvExport)
	}

	dvExports := DaVinciExports{
		exports: exports,
	}

	return &dvExports, nil
}

func (d *DaVinciExports) Validate(providerField terraform.ProviderField) (ok, warning bool, err error) {
	l := logger.Get()
	l.Debug().Msgf("DaVinciExports Validate called.")

	returnOk, returnWarning := true, false

	for _, exportBytes := range d.exports {
		l.Debug().Msgf("Validating export %v.", exportBytes.ExportPath)
		okV, warningV, err := exportBytes.Validate(providerField)
		if err != nil {
			return false, false, err
		}

		if !okV {
			returnOk = okV
		}

		if warningV {
			returnWarning = warningV
		}
	}

	return returnOk, returnWarning, nil
}

func (d *DaVinciExports) Generate(resources []terraform.ProviderResource, version, outputPath string, overwrite bool) (ok bool, err error) {
	exports := make([]export.DaVinciGeneratorExport, 0)

	for _, exportIn := range d.exports {
		export, err := export.New(exportIn.ExportBytes)
		if err != nil {
			return false, err
		}

		if v := exportIn.ExportPath; v != nil {
			export.SetPath(*v)
		}

		exports = append(exports, *export)
	}

	generate := generate.New(exports, resources, outputPath)

	return true, generate.Generate(version, overwrite)
}
