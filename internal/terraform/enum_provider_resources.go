package terraform

type ProviderResource string

const (
	ProviderResourceTypeFlow      ProviderResource = "davinci_flow"
	ProviderResourceTypeVariable  ProviderResource = "davinci_variable"
	ProviderResourceTypeConnection ProviderResource = "davinci_connector"
)

var AllowedProviderResources []string = []string{
	string(ProviderResourceTypeFlow),
	string(ProviderResourceTypeVariable),
	string(ProviderResourceTypeConnection),
}
