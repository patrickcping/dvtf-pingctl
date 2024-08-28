package export

import (
	"encoding/json"

	"github.com/google/go-cmp/cmp"
	"github.com/samir-gandhi/davinci-client-go/davinci"
)

type DaVinciGeneratorExport struct {
	ExportBytes []byte
	Path        *string
	ParsedFlow  *parsedFlow
}

type parsedFlow struct {
	FlowObject any
	ParsedIntf map[string]interface{}
}

func New(exportBytes []byte) (*DaVinciGeneratorExport, error) {
	d := &DaVinciGeneratorExport{
		ExportBytes: exportBytes,
	}

	err := d.ParseFlow()
	if err != nil {
		return nil, err
	}

	return d, nil
}

func (d *DaVinciGeneratorExport) SetPath(path string) {
	d.Path = &path
}

func (d *DaVinciGeneratorExport) IsParsed() bool {
	if d.ParsedFlow == nil || d.ParsedFlow.FlowObject == nil || d.ParsedFlow.ParsedIntf == nil {
		return false
	}

	return true
}

func (d *DaVinciGeneratorExport) ParseFlow() error {

	cmpOpts := davinci.ExportCmpOpts{
		IgnoreConfig:              false,
		IgnoreDesignerCues:        true,
		IgnoreEnvironmentMetadata: false,
		IgnoreUnmappedProperties:  true,
		IgnoreVersionMetadata:     true,
		IgnoreFlowMetadata:        false,
		IgnoreFlowVariables:       false,
	}

	var parsedFlow parsedFlow

	data := &davinci.Flows{}
	err := davinci.Unmarshal(d.ExportBytes, data, cmpOpts)
	if err != nil {
		return err
	}

	if cmp.Equal(data, &davinci.Flows{}) {
		data := &davinci.Flow{}
		err := davinci.Unmarshal(d.ExportBytes, data, cmpOpts)
		if err != nil {
			return err
		}

		parsedFlow.FlowObject = data
	} else {
		parsedFlow.FlowObject = data
	}

	var parsedIntf map[string]interface{}
	err = json.Unmarshal(d.ExportBytes, &parsedIntf)
	if err != nil {
		return err
	}

	parsedFlow.ParsedIntf = parsedIntf

	d.ParsedFlow = &parsedFlow

	return nil
}
