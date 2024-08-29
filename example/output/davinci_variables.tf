// Flow Name: full-basic
resource "davinci_variable" "fdgdfgfdg__full_basic" {
  environment_id = local.pingone_environment_id

  context = "flow"
  flow_id = davinci_flow.full_basic.id

  name        = "fdgdfgfdg"
  type        = "string"

  // Defines a static value.  Comment out or remove both `value` and `empty_value` if the variable value should not be tracked in Terraform state.
  // value = ""
  
  // Defines a static blank string value ("").  Comment out or remove both `value` and `empty_value` if the variable value should not be tracked in Terraform state.
  // empty_value = true

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: full-basic
resource "davinci_variable" "test123__full_basic" {
  environment_id = local.pingone_environment_id

  context = "flow"
  flow_id = davinci_flow.full_basic.id

  name        = "test123"
  type        = "number"
  description = "test123"

  // Defines a static value.  Comment out or remove both `value` and `empty_value` if the variable value should not be tracked in Terraform state.
  value = "10"
  
  // Defines a static blank string value ("").  Comment out or remove both `value` and `empty_value` if the variable value should not be tracked in Terraform state.
  // empty_value = true

  min = 4
  max = 20

  mutable = true
}

