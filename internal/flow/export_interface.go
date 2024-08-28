package flow

import "github.com/patrickcping/dvtf-pingctl/internal/terraform"

type DaVinciExportIntf interface {
	Generate(resources []terraform.ProviderResource, version, outputPath string, overwrite bool) (ok bool, err error)
	Validate(providerField terraform.ProviderField) (ok, warning bool, err error)
}
