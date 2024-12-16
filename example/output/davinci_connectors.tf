// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "annotationconnector__921bfae85c38ed45045e07be703d86b8" {
  environment_id = var.pingone_environment_id

  connector_id = "annotationConnector"
  name         = "Annotation"
  
}

// Flow Name: CIAM-Passwordless-Protect-Magic-Link-Authentication-Subflow
resource "davinci_connection" "challengeconnector__e8b2368e1c5848492047e9c303568605" {
  environment_id = var.pingone_environment_id

  connector_id = "challengeConnector"
  name         = "Challenge"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "errorconnector__53ab83a4a4ab919d9f2cb02d9e111ac8" {
  environment_id = var.pingone_environment_id

  connector_id = "errorConnector"
  name         = "Error Message"
  
}

// Flow Name: OOTB - Device Registration - Subflow - 1
resource "davinci_connection" "errorconnector__6d8f6f706c45fd459a86b3f092602544" {
  environment_id = var.pingone_environment_id

  connector_id = "errorConnector"
  name         = "Error Customize"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "flowconnector__2581eb287bb1d9bd29ae9886d675f89f" {
  environment_id = var.pingone_environment_id

  connector_id = "flowConnector"
  name         = "Flow Connector"
  
  dynamic "property" {
    for_each = concat(
      // Enforce Signed Token
      var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_enforcedSignedToken != null ? [{
        name  = "enforcedSignedToken"
        type  = "boolean"
        value = tostring(var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_enforcedSignedToken)
      }] : [],
      // Input Schema
      var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_inputSchema != null ? [{
        name  = "inputSchema"
        type  = "string"
        value = tostring(var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_inputSchema)
      }] : [],
      // Public Key
      var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_pemPublicKey != null ? [{
        name  = "pemPublicKey"
        type  = "string"
        value = tostring(var.davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_pemPublicKey)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: OOTB - Device Management - Main Flow
resource "davinci_connection" "flowconnector__33329a264e268ab31fb19637debf1ea3" {
  environment_id = var.pingone_environment_id

  connector_id = "flowConnector"
  name         = "Flow Conductor"
  
  dynamic "property" {
    for_each = concat(
      // Enforce Signed Token
      var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_enforcedSignedToken != null ? [{
        name  = "enforcedSignedToken"
        type  = "boolean"
        value = tostring(var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_enforcedSignedToken)
      }] : [],
      // Input Schema
      var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_inputSchema != null ? [{
        name  = "inputSchema"
        type  = "string"
        value = tostring(var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_inputSchema)
      }] : [],
      // Public Key
      var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_pemPublicKey != null ? [{
        name  = "pemPublicKey"
        type  = "string"
        value = tostring(var.davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_pemPublicKey)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "functionsconnector__de650ca45593b82c49064ead10b9fe17" {
  environment_id = var.pingone_environment_id

  connector_id = "functionsConnector"
  name         = "Functions"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "httpconnector__867ed4363b2bc21c860085ad2baa817d" {
  environment_id = var.pingone_environment_id

  connector_id = "httpConnector"
  name         = "Http"
  
  dynamic "property" {
    for_each = concat(
      // Select an OpenID token management connection for signed HTTP responses.
      var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_connectionId != null ? [{
        name  = "connectionId"
        type  = "string"
        value = tostring(var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_connectionId)
      }] : [],
      // reCAPTCHA v2 Secret Key
      var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSecretKey != null ? [{
        name  = "recaptchaSecretKey"
        type  = "string"
        value = tostring(var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSecretKey)
      }] : [],
      // reCAPTCHA v2 Site Key
      var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSiteKey != null ? [{
        name  = "recaptchaSiteKey"
        type  = "string"
        value = tostring(var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSiteKey)
      }] : [],
      // Trusted Sites
      var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_whiteList != null ? [{
        name  = "whiteList"
        type  = "string"
        value = tostring(var.davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_whiteList)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: OOTB - Device Management - Main Flow
resource "davinci_connection" "nodeconnector__3566e86a35c26e575396dcfb89a3dcc0" {
  environment_id = var.pingone_environment_id

  connector_id = "nodeConnector"
  name         = "Teleport"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "nodeconnector__e7eae662d2ca276e4c6f097fc36a3bb1" {
  environment_id = var.pingone_environment_id

  connector_id = "nodeConnector"
  name         = "Node"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "notificationsconnector__cacf3d2861657174d93cbf445d55797a" {
  environment_id = var.pingone_environment_id

  connector_id = "notificationsConnector"
  name         = "PingOne Notifications"
  
  dynamic "property" {
    for_each = concat(
      // Client ID
      var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientId != null ? [{
        name  = "clientId"
        type  = "string"
        value = tostring(var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientId)
      }] : [],
      // Client Secret
      var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientSecret != null ? [{
        name  = "clientSecret"
        type  = "string"
        value = tostring(var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientSecret)
      }] : [],
      // Environment ID
      var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_envId != null ? [{
        name  = "envId"
        type  = "string"
        value = tostring(var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_envId)
      }] : [],
      // Notification Policy ID
      var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_notificationPolicyId != null ? [{
        name  = "notificationPolicyId"
        type  = "string"
        value = tostring(var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_notificationPolicyId)
      }] : [],
      // Region
      var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_region != null ? [{
        name  = "region"
        type  = "string"
        value = tostring(var.davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_region)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "pingoneauthenticationconnector__c3e6a164bde107954e93f5c09f0c8bce" {
  environment_id = var.pingone_environment_id

  connector_id = "pingOneAuthenticationConnector"
  name         = "PingOne Authentication"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949" {
  environment_id = var.pingone_environment_id

  connector_id = "pingOneMfaConnector"
  name         = "PingOne MFA"
  
  dynamic "property" {
    for_each = concat(
      // Client ID
      var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientId != null ? [{
        name  = "clientId"
        type  = "string"
        value = tostring(var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientId)
      }] : [],
      // Client Secret
      var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientSecret != null ? [{
        name  = "clientSecret"
        type  = "string"
        value = tostring(var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientSecret)
      }] : [],
      // Environment ID
      var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_envId != null ? [{
        name  = "envId"
        type  = "string"
        value = tostring(var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_envId)
      }] : [],
      // Policy ID
      var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_policyId != null ? [{
        name  = "policyId"
        type  = "string"
        value = tostring(var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_policyId)
      }] : [],
      // Region
      var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_region != null ? [{
        name  = "region"
        type  = "string"
        value = tostring(var.davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_region)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "pingoneriskconnector__292873d5ceea806d81373ed0341b5c88" {
  environment_id = var.pingone_environment_id

  connector_id = "pingOneRiskConnector"
  name         = "PingOne Protect"
  
  dynamic "property" {
    for_each = concat(
      // Client ID
      var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientId != null ? [{
        name  = "clientId"
        type  = "string"
        value = tostring(var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientId)
      }] : [],
      // Client Secret
      var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientSecret != null ? [{
        name  = "clientSecret"
        type  = "string"
        value = tostring(var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientSecret)
      }] : [],
      // Environment ID
      var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_envId != null ? [{
        name  = "envId"
        type  = "string"
        value = tostring(var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_envId)
      }] : [],
      // Region
      var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_region != null ? [{
        name  = "region"
        type  = "string"
        value = tostring(var.davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_region)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb" {
  environment_id = var.pingone_environment_id

  connector_id = "pingOneSSOConnector"
  name         = "PingOne"
  
  dynamic "property" {
    for_each = concat(
      // Client ID
      var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientId != null ? [{
        name  = "clientId"
        type  = "string"
        value = tostring(var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientId)
      }] : [],
      // Client Secret
      var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientSecret != null ? [{
        name  = "clientSecret"
        type  = "string"
        value = tostring(var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientSecret)
      }] : [],
      // Environment ID
      var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_envId != null ? [{
        name  = "envId"
        type  = "string"
        value = tostring(var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_envId)
      }] : [],
      // Region
      var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_region != null ? [{
        name  = "region"
        type  = "string"
        value = tostring(var.davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_region)
      }] : [],
      
    )
    content {
      name  = property.value.name
      type  = property.value.type
      value = property.value.value
    }
  }
}

// Flow Name: CIAM-Passwordless-Protect-Device-Registration-Subflow
resource "davinci_connection" "stringsconnector__368d3c38f7b0ebe59c8d2aff222c14b0" {
  environment_id = var.pingone_environment_id

  connector_id = "stringsConnector"
  name         = "String"
  
}

// Flow Name: OOTB - Device Registration - Subflow - 1
resource "davinci_connection" "stringsconnector__d49474a1b556eb233d3376c918eb3497" {
  environment_id = var.pingone_environment_id

  connector_id = "stringsConnector"
  name         = "String Manipulation"
  
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_connection" "variablesconnector__06922a684039827499bdbdd97f49827b" {
  environment_id = var.pingone_environment_id

  connector_id = "variablesConnector"
  name         = "Variables"
  
}

