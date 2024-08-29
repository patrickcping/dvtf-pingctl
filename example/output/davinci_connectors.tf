// Flow Name: full-basic
resource "davinci_connection" "errorconnector__fa497c1ceaea43c0886d8d360874a53d" {
  environment_id = local.pingone_environment_id

  connector_id = "errorConnector"
  name         = "abcd123-error"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "flowconnector__84e29d2409ba66c0caf53f9cad0a2049" {
  environment_id = local.pingone_environment_id

  connector_id = "flowConnector"
  name         = "abcd123-flow"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "functionsconnector__548ea933f35b9787ae12ad130f78045b" {
  environment_id = local.pingone_environment_id

  connector_id = "functionsConnector"
  name         = "abcd123-functions"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "httpconnector__481e952e6b11db8360587b8711620786" {
  environment_id = local.pingone_environment_id

  connector_id = "httpConnector"
  name         = "HTTP"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

// Flow Name: full-basic
resource "davinci_connection" "variablesconnector__9f8f97e94ad87e184960633b424d80b6" {
  environment_id = local.pingone_environment_id

  connector_id = "variablesConnector"
  name         = "abcd123-variables"

  // properties based on the connector type
  // Visit the DaVinci Connector Parameter Reference for details of the required properties:
  // https://registry.terraform.io/providers/pingidentity/davinci/latest/docs/guides/connector-reference
}

