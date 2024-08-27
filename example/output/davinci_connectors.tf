// Flow Name: full-basic
resource "davinci_connection" "abcd123_error" {
  environment_id = local.pingone_environment_id

  connector_id = "errorConnector"
  name         = "abcd123-error"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "abcd123_flow" {
  environment_id = local.pingone_environment_id

  connector_id = "flowConnector"
  name         = "abcd123-flow"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "abcd123_functions" {
  environment_id = local.pingone_environment_id

  connector_id = "functionsConnector"
  name         = "abcd123-functions"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "abcd123_variables" {
  environment_id = local.pingone_environment_id

  connector_id = "variablesConnector"
  name         = "abcd123-variables"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "http" {
  environment_id = local.pingone_environment_id

  connector_id = "httpConnector"
  name         = "HTTP"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

