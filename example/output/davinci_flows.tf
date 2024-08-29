// Flow Name: abcd123-subflow-1
resource "davinci_flow" "abcd123_subflow_1" {

  environment_id = local.pingone_environment_id

  name        = "abcd123-subflow-1"
  description = "Imported on Thu May 23 2024 15:37:14 GMT+0000 (Coordinated Universal Time)"

  flow_json = file("assets/flows/abcd123_subflow_1.json")


  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__9cb5e3fdbbf0eeb602e0ff332ad79e5d.id
    name                         = davinci_connection.httpconnector__9cb5e3fdbbf0eeb602e0ff332ad79e5d.name
    replace_import_connection_id = "9cb5e3fdbbf0eeb602e0ff332ad79e5d"
  }
}

// Flow Name: abcd123-subflow-2
resource "davinci_flow" "abcd123_subflow_2" {

  environment_id = local.pingone_environment_id

  name        = "abcd123-subflow-2"
  description = "Cloned on Wed Jan 31 2024 13:43:43 GMT+0000 (Coordinated Universal Time)."

  flow_json = file("assets/flows/abcd123_subflow_2.json")


  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__9cb5e3fdbbf0eeb602e0ff332ad79e5d.id
    name                         = davinci_connection.httpconnector__9cb5e3fdbbf0eeb602e0ff332ad79e5d.name
    replace_import_connection_id = "9cb5e3fdbbf0eeb602e0ff332ad79e5d"
  }
}

// Flow Name: full-basic
resource "davinci_flow" "full_basic" {

  environment_id = local.pingone_environment_id

  name        = "full-basic"
  description = "Imported on Wed Aug 14 2024 12:20:23 GMT+0000 (Coordinated Universal Time)"

  flow_json = file("assets/flows/full_basic.json")


  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__fa497c1ceaea43c0886d8d360874a53d.id
    name                         = davinci_connection.errorconnector__fa497c1ceaea43c0886d8d360874a53d.name
    replace_import_connection_id = "fa497c1ceaea43c0886d8d360874a53d"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__84e29d2409ba66c0caf53f9cad0a2049.id
    name                         = davinci_connection.flowconnector__84e29d2409ba66c0caf53f9cad0a2049.name
    replace_import_connection_id = "84e29d2409ba66c0caf53f9cad0a2049"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__548ea933f35b9787ae12ad130f78045b.id
    name                         = davinci_connection.functionsconnector__548ea933f35b9787ae12ad130f78045b.name
    replace_import_connection_id = "548ea933f35b9787ae12ad130f78045b"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__481e952e6b11db8360587b8711620786.id
    name                         = davinci_connection.httpconnector__481e952e6b11db8360587b8711620786.name
    replace_import_connection_id = "481e952e6b11db8360587b8711620786"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__9f8f97e94ad87e184960633b424d80b6.id
    name                         = davinci_connection.variablesconnector__9f8f97e94ad87e184960633b424d80b6.name
    replace_import_connection_id = "9f8f97e94ad87e184960633b424d80b6"
  }


  // Subflow link: abcd123-subflow-1
  subflow_link {
    id                        = davinci_flow.abcd123_subflow_1.id
    name                      = davinci_flow.abcd123_subflow_1.name
    replace_import_subflow_id = "e7cf51f064dad2d3888f55c4616e5c37"
  }

  // Subflow link: abcd123-subflow-2
  subflow_link {
    id                        = davinci_flow.abcd123_subflow_2.id
    name                      = davinci_flow.abcd123_subflow_2.name
    replace_import_subflow_id = "29aea97a66e792a630b96597faf337cd"
  }
}

