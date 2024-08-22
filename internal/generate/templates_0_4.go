package generate

import _ "embed"

//go:embed templates/0.4/hcl_davinci_connection.tmpl
var HCLConnectionResourceTemplate_0_4 string

//go:embed templates/0.4/hcl_davinci_flow.tmpl
var HCLFlowResourceTemplate_0_4 string

//go:embed templates/0.4/hcl_davinci_variable.tmpl
var HCLVariableResourceTemplate_0_4 string
