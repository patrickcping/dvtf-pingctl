// Flow Name: CIAM-Passwordless-Protect-Account-Recovery-Subflow
resource "davinci_flow" "ciam_passwordless_protect_account_recovery_subflow" {
  depends_on = [
    davinci_variable.ciam_errormessage,
    davinci_variable.ciam_protectdevicestatus,
    davinci_variable.ciam_protectpredictor,
    davinci_variable.ciam_protectriskid,
    davinci_variable.ciam_protectrisklevel,
    davinci_variable.ciam_protectriskpolicyid,
    davinci_variable.ciam_recoverylimit,
    davinci_variable.ciam_recoveryvalidationattempts,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.id
    name                         = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: notificationsConnector
  connection_link {
    id                           = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.id
    name                         = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }

  // Connector link: pingOneRiskConnector
  connection_link {
    id                           = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.id
    name                         = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  // Subflow link: CIAM-Passwordless-Protect-Threat-Detection-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.name
    replace_import_subflow_id = "18a7d1ba0e345c1db700a883486aebb3"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Account-Registration-Subflow
resource "davinci_flow" "ciam_passwordless_protect_account_registration_subflow" {
  depends_on = [
    davinci_variable.ciam_errormessage,
    davinci_variable.ciam_protectdevicestatus,
    davinci_variable.ciam_protectpredictor,
    davinci_variable.ciam_protectriskid,
    davinci_variable.ciam_protectrisklevel,
    davinci_variable.ciam_protectriskpolicyid,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.id
    name                         = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: pingOneRiskConnector
  connection_link {
    id                           = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.id
    name                         = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  // Subflow link: CIAM-Passwordless-Protect-Agreement(ToS)-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_agreement_tos_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_agreement_tos_subflow.name
    replace_import_subflow_id = "1784336e5064e4374a37373276477b66"
  }

  // Subflow link: CIAM-Passwordless-Protect-Device-Registration-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_device_registration_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_device_registration_subflow.name
    replace_import_subflow_id = "5be161246a2c62c75bdecfc28e3a8ed9"
  }

  // Subflow link: CIAM-Passwordless-Protect-Threat-Detection-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.name
    replace_import_subflow_id = "18a7d1ba0e345c1db700a883486aebb3"
  }

  // Subflow link: CIAM-Passwordless-Protect-Verify-Email-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_verify_email_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_verify_email_subflow.name
    replace_import_subflow_id = "88f3e564d1b8a766cedcdfb2a968e730"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Agreement(ToS)-Subflow
resource "davinci_flow" "ciam_passwordless_protect_agreement_tos_subflow" {

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Change-Password-Subflow
resource "davinci_flow" "ciam_passwordless_protect_change_password_subflow" {
  depends_on = [
    davinci_variable.ciam_errormessage,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_change_password_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_change_password_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_change_password_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Device-Authentication-Subflow
resource "davinci_flow" "ciam_passwordless_protect_device_authentication_subflow" {
  depends_on = [
    davinci_variable.ciam_protectdevicestatus,
    davinci_variable.ciam_protectpredictor,
    davinci_variable.ciam_protectriskid,
    davinci_variable.ciam_protectrisklevel,
    davinci_variable.ciam_protectriskpolicyid,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.id
    name                         = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: notificationsConnector
  connection_link {
    id                           = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.id
    name                         = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }

  // Connector link: pingOneMfaConnector
  connection_link {
    id                           = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.id
    name                         = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  // Connector link: pingOneRiskConnector
  connection_link {
    id                           = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.id
    name                         = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  // Subflow link: CIAM-Passwordless-Protect-Magic-Link-Authentication-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_magic_link_authentication_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_magic_link_authentication_subflow.name
    replace_import_subflow_id = "0f34ee06862fdbaa1be74299461b5e47"
  }

  // Subflow link: CIAM-Passwordless-Protect-Threat-Detection-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.name
    replace_import_subflow_id = "18a7d1ba0e345c1db700a883486aebb3"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Device-Registration-Subflow
resource "davinci_flow" "ciam_passwordless_protect_device_registration_subflow" {
  depends_on = [
    davinci_variable.ciam_deviceid,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: pingOneMfaConnector
  connection_link {
    id                           = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.id
    name                         = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  // Connector link: stringsConnector
  connection_link {
    id                           = davinci_connection.stringsconnector__368d3c38f7b0ebe59c8d2aff222c14b0.id
    name                         = davinci_connection.stringsconnector__368d3c38f7b0ebe59c8d2aff222c14b0.name
    replace_import_connection_id = "368d3c38f7b0ebe59c8d2aff222c14b0"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Magic-Link-Authentication-Subflow
resource "davinci_flow" "ciam_passwordless_protect_magic_link_authentication_subflow" {
  depends_on = [
    davinci_variable.ciam_companyname,
    davinci_variable.ciam_logostyle,
    davinci_variable.ciam_logourl,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: challengeConnector
  connection_link {
    id                           = davinci_connection.challengeconnector__e8b2368e1c5848492047e9c303568605.id
    name                         = davinci_connection.challengeconnector__e8b2368e1c5848492047e9c303568605.name
    replace_import_connection_id = "e8b2368e1c5848492047e9c303568605"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.id
    name                         = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: notificationsConnector
  connection_link {
    id                           = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.id
    name                         = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_flow" "ciam_passwordless_protect_registration_authentication_account_recovery_main_flow" {
  depends_on = [
    davinci_variable.agreementid,
    davinci_variable.ciam_accountrecoveryenabled,
    davinci_variable.ciam_agreementenabled,
    davinci_variable.ciam_appleenabled,
    davinci_variable.ciam_authmethod,
    davinci_variable.ciam_companyname,
    davinci_variable.ciam_emailotpenabled,
    davinci_variable.ciam_facebookenabled,
    davinci_variable.ciam_fidopasskeyenabled,
    davinci_variable.ciam_googleenabled,
    davinci_variable.ciam_logostyle,
    davinci_variable.ciam_logourl,
    davinci_variable.ciam_magiclinkenabled,
    davinci_variable.ciam_passwordlessrequired,
    davinci_variable.ciam_protectdevicestatus,
    davinci_variable.ciam_protectpredictor,
    davinci_variable.ciam_protectriskid,
    davinci_variable.ciam_protectrisklevel,
    davinci_variable.ciam_protectriskpolicyid,
    davinci_variable.ciam_sessionlengthinminute,
    davinci_variable.ciam_smsotpenabled,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_name
  description = var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.id
    name                         = davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f.name
    replace_import_connection_id = "2581eb287bb1d9bd29ae9886d675f89f"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: notificationsConnector
  connection_link {
    id                           = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.id
    name                         = davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a.name
    replace_import_connection_id = "cacf3d2861657174d93cbf445d55797a"
  }

  // Connector link: pingOneAuthenticationConnector
  connection_link {
    id                           = davinci_connection.pingoneauthenticationconnector__c3e6a164bde107954e93f5c09f0c8bce.id
    name                         = davinci_connection.pingoneauthenticationconnector__c3e6a164bde107954e93f5c09f0c8bce.name
    replace_import_connection_id = "c3e6a164bde107954e93f5c09f0c8bce"
  }

  // Connector link: pingOneMfaConnector
  connection_link {
    id                           = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.id
    name                         = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  // Connector link: pingOneRiskConnector
  connection_link {
    id                           = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.id
    name                         = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }


  // Subflow link: CIAM-Passwordless-Protect-Account-Recovery-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_account_recovery_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_account_recovery_subflow.name
    replace_import_subflow_id = "5656e7f3b5db2c99a9ef74990ce1f76d"
  }

  // Subflow link: CIAM-Passwordless-Protect-Account-Registration-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_account_registration_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_account_registration_subflow.name
    replace_import_subflow_id = "d117963134486e4eac02b20c0ca9c0ab"
  }

  // Subflow link: CIAM-Passwordless-Protect-Agreement(ToS)-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_agreement_tos_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_agreement_tos_subflow.name
    replace_import_subflow_id = "1784336e5064e4374a37373276477b66"
  }

  // Subflow link: CIAM-Passwordless-Protect-Change-Password-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_change_password_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_change_password_subflow.name
    replace_import_subflow_id = "37b34222e13d6923bc7d4231a9bc9a9c"
  }

  // Subflow link: CIAM-Passwordless-Protect-Device-Authentication-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_device_authentication_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_device_authentication_subflow.name
    replace_import_subflow_id = "dd24abc1277445f905c34dd1f94eec58"
  }

  // Subflow link: CIAM-Passwordless-Protect-Threat-Detection-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_threat_detection_subflow.name
    replace_import_subflow_id = "18a7d1ba0e345c1db700a883486aebb3"
  }

  // Subflow link: CIAM-Passwordless-Protect-Verify-Email-Subflow
  subflow_link {
    id                        = davinci_flow.ciam_passwordless_protect_verify_email_subflow.id
    name                      = davinci_flow.ciam_passwordless_protect_verify_email_subflow.name
    replace_import_subflow_id = "88f3e564d1b8a766cedcdfb2a968e730"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Threat-Detection-Subflow
resource "davinci_flow" "ciam_passwordless_protect_threat_detection_subflow" {
  depends_on = [
    davinci_variable.companyname,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: pingOneRiskConnector
  connection_link {
    id                           = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.id
    name                         = davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88.name
    replace_import_connection_id = "292873d5ceea806d81373ed0341b5c88"
  }
}

// Flow Name: CIAM-Passwordless-Protect-Verify-Email-Subflow
resource "davinci_flow" "ciam_passwordless_protect_verify_email_subflow" {
  depends_on = [
    davinci_variable.ciam_verificationlimit,
    davinci_variable.ciam_verificationvalidationattempts,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_name
  description = var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_description
  log_level   = var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_log_level

  flow_json = var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path != null ? (fileexists(var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path) ? file(var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path))) : var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.id
    name                         = davinci_connection.errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8.name
    replace_import_connection_id = "53ab83a4a4ab919d9f2cb02d9e111ac8"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.id
    name                         = davinci_connection.nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1.name
    replace_import_connection_id = "e7eae662d2ca276e4c6f097fc36a3bb1"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
}

// Flow Name: OOTB - Basic Profile Management
resource "davinci_flow" "ootb_basic_profile_management" {
  depends_on = [
    davinci_variable.username,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ootb_basic_profile_management_name
  description = var.davinci_flow_ootb_basic_profile_management_description
  log_level   = var.davinci_flow_ootb_basic_profile_management_log_level

  flow_json = var.davinci_flow_ootb_basic_profile_management_json_file_path != null ? (fileexists(var.davinci_flow_ootb_basic_profile_management_json_file_path) ? file(var.davinci_flow_ootb_basic_profile_management_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ootb_basic_profile_management_json_file_path))) : var.davinci_flow_ootb_basic_profile_management_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.id
    name                         = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.name
    replace_import_connection_id = "6d8f6f706c45fd459a86b3f092602544"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
}

// Flow Name: OOTB - Change Password - Subflow - 1
resource "davinci_flow" "ootb_change_password_subflow_1" {

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ootb_change_password_subflow_1_name
  description = var.davinci_flow_ootb_change_password_subflow_1_description
  log_level   = var.davinci_flow_ootb_change_password_subflow_1_log_level

  flow_json = var.davinci_flow_ootb_change_password_subflow_1_json_file_path != null ? (fileexists(var.davinci_flow_ootb_change_password_subflow_1_json_file_path) ? file(var.davinci_flow_ootb_change_password_subflow_1_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ootb_change_password_subflow_1_json_file_path))) : var.davinci_flow_ootb_change_password_subflow_1_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.id
    name                         = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.name
    replace_import_connection_id = "6d8f6f706c45fd459a86b3f092602544"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.id
    name                         = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }
}

// Flow Name: OOTB - Device Management - Main Flow
resource "davinci_flow" "ootb_device_management_main_flow" {
  depends_on = [
    davinci_variable.ciam_companyname,
    davinci_variable.ciam_emailotpenabled,
    davinci_variable.ciam_fidopasskeyenabled,
    davinci_variable.ciam_logostyle,
    davinci_variable.ciam_logourl,
    davinci_variable.ciam_smsotpenabled,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ootb_device_management_main_flow_name
  description = var.davinci_flow_ootb_device_management_main_flow_description
  log_level   = var.davinci_flow_ootb_device_management_main_flow_log_level

  flow_json = var.davinci_flow_ootb_device_management_main_flow_json_file_path != null ? (fileexists(var.davinci_flow_ootb_device_management_main_flow_json_file_path) ? file(var.davinci_flow_ootb_device_management_main_flow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ootb_device_management_main_flow_json_file_path))) : var.davinci_flow_ootb_device_management_main_flow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__33329a264e268ab31fb19637debf1ea3.id
    name                         = davinci_connection.flowconnector__33329a264e268ab31fb19637debf1ea3.name
    replace_import_connection_id = "33329a264e268ab31fb19637debf1ea3"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.id
    name                         = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }

  // Connector link: pingOneMfaConnector
  connection_link {
    id                           = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.id
    name                         = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }


  // Subflow link: OOTB - Device Registration - Subflow - 1
  subflow_link {
    id                        = davinci_flow.ootb_device_registration_subflow_1.id
    name                      = davinci_flow.ootb_device_registration_subflow_1.name
    replace_import_subflow_id = "3cb25bcaf0c9d695b183fc2db122db44"
  }
}

// Flow Name: OOTB - Device Registration - Subflow - 1
resource "davinci_flow" "ootb_device_registration_subflow_1" {
  depends_on = [
    davinci_variable.ciam_deviceid,
  ]

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ootb_device_registration_subflow_1_name
  description = var.davinci_flow_ootb_device_registration_subflow_1_description
  log_level   = var.davinci_flow_ootb_device_registration_subflow_1_log_level

  flow_json = var.davinci_flow_ootb_device_registration_subflow_1_json_file_path != null ? (fileexists(var.davinci_flow_ootb_device_registration_subflow_1_json_file_path) ? file(var.davinci_flow_ootb_device_registration_subflow_1_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ootb_device_registration_subflow_1_json_file_path))) : var.davinci_flow_ootb_device_registration_subflow_1_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: errorConnector
  connection_link {
    id                           = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.id
    name                         = davinci_connection.errorconnector__6d8f6f706c45fd459a86b3f092602544.name
    replace_import_connection_id = "6d8f6f706c45fd459a86b3f092602544"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.id
    name                         = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }

  // Connector link: pingOneMfaConnector
  connection_link {
    id                           = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.id
    name                         = davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949.name
    replace_import_connection_id = "b72bd44e6be8180bd5988ac74cd9c949"
  }

  // Connector link: stringsConnector
  connection_link {
    id                           = davinci_connection.stringsconnector__d49474a1b556eb233d3376c918eb3497.id
    name                         = davinci_connection.stringsconnector__d49474a1b556eb233d3376c918eb3497.name
    replace_import_connection_id = "d49474a1b556eb233d3376c918eb3497"
  }

  // Connector link: variablesConnector
  connection_link {
    id                           = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.id
    name                         = davinci_connection.variablesconnector__06922a684039827499bdbdd97f49827b.name
    replace_import_connection_id = "06922a684039827499bdbdd97f49827b"
  }
}

// Flow Name: OOTB - Password Reset - Main Flow
resource "davinci_flow" "ootb_password_reset_main_flow" {

  environment_id = var.pingone_environment_id

  name        = var.davinci_flow_ootb_password_reset_main_flow_name
  description = var.davinci_flow_ootb_password_reset_main_flow_description
  log_level   = var.davinci_flow_ootb_password_reset_main_flow_log_level

  flow_json = var.davinci_flow_ootb_password_reset_main_flow_json_file_path != null ? (fileexists(var.davinci_flow_ootb_password_reset_main_flow_json_file_path) ? file(var.davinci_flow_ootb_password_reset_main_flow_json_file_path) : file(format("%s/%s", path.module, var.davinci_flow_ootb_password_reset_main_flow_json_file_path))) : var.davinci_flow_ootb_password_reset_main_flow_json


  // Connector link: annotationConnector
  connection_link {
    id                           = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.id
    name                         = davinci_connection.annotationconnector__921bfae85c38ed45045e07be703d86b8.name
    replace_import_connection_id = "921bfae85c38ed45045e07be703d86b8"
  }

  // Connector link: flowConnector
  connection_link {
    id                           = davinci_connection.flowconnector__33329a264e268ab31fb19637debf1ea3.id
    name                         = davinci_connection.flowconnector__33329a264e268ab31fb19637debf1ea3.name
    replace_import_connection_id = "33329a264e268ab31fb19637debf1ea3"
  }

  // Connector link: functionsConnector
  connection_link {
    id                           = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.id
    name                         = davinci_connection.functionsconnector__de650ca45593b82c49064ead10b9fe17.name
    replace_import_connection_id = "de650ca45593b82c49064ead10b9fe17"
  }

  // Connector link: httpConnector
  connection_link {
    id                           = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.id
    name                         = davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d.name
    replace_import_connection_id = "867ed4363b2bc21c860085ad2baa817d"
  }

  // Connector link: nodeConnector
  connection_link {
    id                           = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.id
    name                         = davinci_connection.nodeconnector__3566e86a35c26e575396dcfb89a3dcc0.name
    replace_import_connection_id = "3566e86a35c26e575396dcfb89a3dcc0"
  }

  // Connector link: pingOneSSOConnector
  connection_link {
    id                           = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.id
    name                         = davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb.name
    replace_import_connection_id = "94141bf2f1b9b59a5f5365ff135e02bb"
  }


  // Subflow link: OOTB - Change Password - Subflow - 1
  subflow_link {
    id                        = davinci_flow.ootb_change_password_subflow_1.id
    name                      = davinci_flow.ootb_change_password_subflow_1.name
    replace_import_subflow_id = "eafe5dfe5544306c425e01ba37328a6d"
  }
}

