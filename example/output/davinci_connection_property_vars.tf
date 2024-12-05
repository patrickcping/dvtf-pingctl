
// Properties for the "Flow Connector" connector, with connector ID flowConnector.
// Terraform Resource: davinci_connection.flowconnector__2581eb287bb1d9bd29ae9886d675f89f

// The 'Enforce Signed Token' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. 
variable "davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_enforcedSignedToken" {
  type = bool
  
  description = "The 'Enforce Signed Token' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. "
  default = null
}

// The 'Input Schema' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. Follow example for JSON schema.
variable "davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_inputSchema" {
  type = string
  
  description = "The 'Input Schema' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. Follow example for JSON schema."
  default = null
}

// The 'Public Key' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. pem public key
variable "davinci_connection_flowconnector__2581eb287bb1d9bd29ae9886d675f89f_pemPublicKey" {
  type = string
  
  description = "The 'Public Key' property for the connector named 'Flow Connector' with connector ID 'flowConnector'. pem public key"
  default = null
}

// Properties for the "Flow Conductor" connector, with connector ID flowConnector.
// Terraform Resource: davinci_connection.flowconnector__33329a264e268ab31fb19637debf1ea3

// The 'Enforce Signed Token' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. 
variable "davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_enforcedSignedToken" {
  type = bool
  
  description = "The 'Enforce Signed Token' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. "
  default = null
}

// The 'Input Schema' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. Follow example for JSON schema.
variable "davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_inputSchema" {
  type = string
  
  description = "The 'Input Schema' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. Follow example for JSON schema."
  default = null
}

// The 'Public Key' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. pem public key
variable "davinci_connection_flowconnector__33329a264e268ab31fb19637debf1ea3_pemPublicKey" {
  type = string
  
  description = "The 'Public Key' property for the connector named 'Flow Conductor' with connector ID 'flowConnector'. pem public key"
  default = null
}

// Properties for the "Http" connector, with connector ID httpConnector.
// Terraform Resource: davinci_connection.httpconnector__867ed4363b2bc21c860085ad2baa817d

// The 'Select an OpenID token management connection for signed HTTP responses.' property for the connector named 'Http' with connector ID 'httpConnector'. 
variable "davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_connectionId" {
  type = string
  
  description = "The 'Select an OpenID token management connection for signed HTTP responses.' property for the connector named 'Http' with connector ID 'httpConnector'. "
  default = null
}

// The 'reCAPTCHA v2 Secret Key' property for the connector named 'Http' with connector ID 'httpConnector'. The Secret Key from reCAPTCHA Admin dashboard.
variable "davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSecretKey" {
  type = string
  
  description = "The 'reCAPTCHA v2 Secret Key' property for the connector named 'Http' with connector ID 'httpConnector'. The Secret Key from reCAPTCHA Admin dashboard."
  default = null
}

// The 'reCAPTCHA v2 Site Key' property for the connector named 'Http' with connector ID 'httpConnector'. The Site Key from reCAPTCHA Admin dashboard.
variable "davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_recaptchaSiteKey" {
  type = string
  
  description = "The 'reCAPTCHA v2 Site Key' property for the connector named 'Http' with connector ID 'httpConnector'. The Site Key from reCAPTCHA Admin dashboard."
  default = null
}

// The 'Trusted Sites' property for the connector named 'Http' with connector ID 'httpConnector'. Enter the hostname for the trusted sites that host your HTML. Note: Ensure that the content hosted on these sites can be trusted and that publishing safeguards are in place to prevent unexpected issues.
variable "davinci_connection_httpconnector__867ed4363b2bc21c860085ad2baa817d_whiteList" {
  type = string
  
  description = "The 'Trusted Sites' property for the connector named 'Http' with connector ID 'httpConnector'. Enter the hostname for the trusted sites that host your HTML. Note: Ensure that the content hosted on these sites can be trusted and that publishing safeguards are in place to prevent unexpected issues."
  default = null
}

// Properties for the "PingOne Notifications" connector, with connector ID notificationsConnector.
// Terraform Resource: davinci_connection.notificationsconnector__cacf3d2861657174d93cbf445d55797a

// The 'Client ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The Client ID of your PingOne Worker application.
variable "davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientId" {
  type = string
  
  description = "The 'Client ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The Client ID of your PingOne Worker application."
  default = null
}

// The 'Client Secret' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The Client Secret of your PingOne Worker application.
variable "davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_clientSecret" {
  type = string
  
  description = "The 'Client Secret' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The Client Secret of your PingOne Worker application."
  default = null
}

// The 'Environment ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. Your PingOne Environment ID.
variable "davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_envId" {
  type = string
  
  description = "The 'Environment ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. Your PingOne Environment ID."
  default = null
}

// The 'Notification Policy ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. A unique identifier for the policy.
variable "davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_notificationPolicyId" {
  type = string
  
  description = "The 'Notification Policy ID' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. A unique identifier for the policy."
  default = null
}

// The 'Region' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The region in which your PingOne environment exists.
variable "davinci_connection_notificationsconnector__cacf3d2861657174d93cbf445d55797a_region" {
  type = string
  
  description = "The 'Region' property for the connector named 'PingOne Notifications' with connector ID 'notificationsConnector'. The region in which your PingOne environment exists."
  default = null
}

// Properties for the "PingOne MFA" connector, with connector ID pingOneMfaConnector.
// Terraform Resource: davinci_connection.pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949

// The 'Client ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The Client ID of your PingOne Worker application.
variable "davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientId" {
  type = string
  
  description = "The 'Client ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The Client ID of your PingOne Worker application."
  default = null
}

// The 'Client Secret' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The Client Secret of your PingOne Worker application.
variable "davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_clientSecret" {
  type = string
  
  description = "The 'Client Secret' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The Client Secret of your PingOne Worker application."
  default = null
}

// The 'Environment ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. Your PingOne Environment ID.
variable "davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_envId" {
  type = string
  
  description = "The 'Environment ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. Your PingOne Environment ID."
  default = null
}

// The 'Policy ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The ID of your PingOne MFA device authentication policy.
variable "davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_policyId" {
  type = string
  
  description = "The 'Policy ID' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The ID of your PingOne MFA device authentication policy."
  default = null
}

// The 'Region' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The region in which your PingOne environment exists.
variable "davinci_connection_pingonemfaconnector__b72bd44e6be8180bd5988ac74cd9c949_region" {
  type = string
  
  description = "The 'Region' property for the connector named 'PingOne MFA' with connector ID 'pingOneMfaConnector'. The region in which your PingOne environment exists."
  default = null
}

// Properties for the "PingOne Protect" connector, with connector ID pingOneRiskConnector.
// Terraform Resource: davinci_connection.pingoneriskconnector__292873d5ceea806d81373ed0341b5c88

// The 'Client ID' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. The id for your Application found in Ping's Dashboard
variable "davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientId" {
  type = string
  
  description = "The 'Client ID' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. The id for your Application found in Ping's Dashboard"
  default = null
}

// The 'Client Secret' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. Client Secret from your App in Ping's Dashboard
variable "davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_clientSecret" {
  type = string
  
  description = "The 'Client Secret' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. Client Secret from your App in Ping's Dashboard"
  default = null
}

// The 'Environment ID' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. Your Environment ID provided by Ping.
variable "davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_envId" {
  type = string
  
  description = "The 'Environment ID' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. Your Environment ID provided by Ping."
  default = null
}

// The 'Region' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. The region your PingOne environment is in.
variable "davinci_connection_pingoneriskconnector__292873d5ceea806d81373ed0341b5c88_region" {
  type = string
  
  description = "The 'Region' property for the connector named 'PingOne Protect' with connector ID 'pingOneRiskConnector'. The region your PingOne environment is in."
  default = null
}

// Properties for the "PingOne" connector, with connector ID pingOneSSOConnector.
// Terraform Resource: davinci_connection.pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb

// The 'Client ID' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The Client ID of your PingOne Worker application.
variable "davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientId" {
  type = string
  
  description = "The 'Client ID' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The Client ID of your PingOne Worker application."
  default = null
}

// The 'Client Secret' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The Client Secret of your PingOne Worker application.
variable "davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_clientSecret" {
  type = string
  
  description = "The 'Client Secret' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The Client Secret of your PingOne Worker application."
  default = null
}

// The 'Environment ID' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. Your PingOne environment ID.
variable "davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_envId" {
  type = string
  
  description = "The 'Environment ID' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. Your PingOne environment ID."
  default = null
}

// The 'Region' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The region in which your PingOne environment exists.
variable "davinci_connection_pingonessoconnector__94141bf2f1b9b59a5f5365ff135e02bb_region" {
  type = string
  
  description = "The 'Region' property for the connector named 'PingOne' with connector ID 'pingOneSSOConnector'. The region in which your PingOne environment exists."
  default = null
}
