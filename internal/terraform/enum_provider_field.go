package terraform

type ProviderField string

const (
	ProviderFieldTypeFlowJson              ProviderField = "flow_json"
	ProviderFieldTypeFlowConfigurationJson ProviderField = "flow_configuration_json"
	ProviderFieldTypeFlowExportJson        ProviderField = "flow_export_json"
)

var AllowedProviderFields []string = []string{
	string(ProviderFieldTypeFlowJson),
	string(ProviderFieldTypeFlowConfigurationJson),
	string(ProviderFieldTypeFlowExportJson),
}
