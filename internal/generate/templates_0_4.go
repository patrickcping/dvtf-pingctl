package generate

import _ "embed"

//go:embed templates/0.4/hcl_davinci_connection_property_vars.tf.tmpl
var HCLConnectionPropertyVarsTemplate_0_4 string

//go:embed templates/0.4/hcl_davinci_connection.tf.tmpl
var HCLConnectionResourceTemplate_0_4 string

//go:embed templates/0.4/hcl_davinci_flow.tf.tmpl
var HCLFlowResourceTemplate_0_4 string

//go:embed templates/0.4/hcl_davinci_variable.tf.tmpl
var HCLVariableResourceTemplate_0_4 string

//go:embed templates/0.4/hcl_vars.tf.tmpl
var HCLVarsTemplate_0_4 string

//go:embed templates/0.4/hcl_versions.tf.tmpl
var HCLVersionsTemplate_0_4 string
