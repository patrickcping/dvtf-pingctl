// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "agreementid" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "agreementId"
  type        = "string"
  description = var.davinci_variable_agreementid_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_agreementid_value == "" ? null : var.davinci_variable_agreementid_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_agreementid_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_accountrecoveryenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_accountRecoveryEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_accountrecoveryenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_accountrecoveryenabled_value == "" ? null : var.davinci_variable_ciam_accountrecoveryenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_accountrecoveryenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_agreementenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_agreementEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_agreementenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_agreementenabled_value == "" ? null : var.davinci_variable_ciam_agreementenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_agreementenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_appleenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_appleEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_appleenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_appleenabled_value == "" ? null : var.davinci_variable_ciam_appleenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_appleenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_authmethod" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_authMethod"
  type        = "string"
  description = var.davinci_variable_ciam_authmethod_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_authmethod_value == "" ? null : var.davinci_variable_ciam_authmethod_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_authmethod_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_companyname" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_companyName"
  type        = "string"
  description = var.davinci_variable_ciam_companyname_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_companyname_value == "" ? null : var.davinci_variable_ciam_companyname_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_companyname_value == "" ? true : null

  min = 0
  max = 2000
}

// Flow Name: CIAM-Passwordless-Protect-Device-Registration-Subflow
resource "davinci_variable" "ciam_deviceid" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_deviceId"
  type        = "string"
  description = var.davinci_variable_ciam_deviceid_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_deviceid_value == "" ? null : var.davinci_variable_ciam_deviceid_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_deviceid_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_emailotpenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_emailOtpEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_emailotpenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_emailotpenabled_value == "" ? null : var.davinci_variable_ciam_emailotpenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_emailotpenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Account-Recovery-Subflow
resource "davinci_variable" "ciam_errormessage" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_errorMessage"
  type        = "string"
  description = var.davinci_variable_ciam_errormessage_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_errormessage_value == "" ? null : var.davinci_variable_ciam_errormessage_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_errormessage_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_facebookenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_facebookEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_facebookenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_facebookenabled_value == "" ? null : var.davinci_variable_ciam_facebookenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_facebookenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_fidopasskeyenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_fidoPasskeyEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_fidopasskeyenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_fidopasskeyenabled_value == "" ? null : var.davinci_variable_ciam_fidopasskeyenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_fidopasskeyenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_googleenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_googleEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_googleenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_googleenabled_value == "" ? null : var.davinci_variable_ciam_googleenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_googleenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_logostyle" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_logoStyle"
  type        = "string"
  description = var.davinci_variable_ciam_logostyle_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_logostyle_value == "" ? null : var.davinci_variable_ciam_logostyle_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_logostyle_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_logourl" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_logoUrl"
  type        = "string"
  description = var.davinci_variable_ciam_logourl_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_logourl_value == "" ? null : var.davinci_variable_ciam_logourl_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_logourl_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_magiclinkenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_magicLinkEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_magiclinkenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_magiclinkenabled_value == "" ? null : var.davinci_variable_ciam_magiclinkenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_magiclinkenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_passwordlessrequired" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_passwordlessRequired"
  type        = "boolean"
  description = var.davinci_variable_ciam_passwordlessrequired_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_passwordlessrequired_value == "" ? null : var.davinci_variable_ciam_passwordlessrequired_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_passwordlessrequired_value == "" ? true : null

  min = 0
  max = 2000
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_protectdevicestatus" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_protectDeviceStatus"
  type        = "string"
  description = var.davinci_variable_ciam_protectdevicestatus_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_protectdevicestatus_value == "" ? null : var.davinci_variable_ciam_protectdevicestatus_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_protectdevicestatus_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_protectpredictor" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_protectPredictor"
  type        = "string"
  description = var.davinci_variable_ciam_protectpredictor_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_protectpredictor_value == "" ? null : var.davinci_variable_ciam_protectpredictor_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_protectpredictor_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_protectriskid" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_protectRiskID"
  type        = "string"
  description = var.davinci_variable_ciam_protectriskid_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_protectriskid_value == "" ? null : var.davinci_variable_ciam_protectriskid_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_protectriskid_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_protectrisklevel" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_protectRiskLevel"
  type        = "string"
  description = var.davinci_variable_ciam_protectrisklevel_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_protectrisklevel_value == "" ? null : var.davinci_variable_ciam_protectrisklevel_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_protectrisklevel_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_protectriskpolicyid" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_protectriskPolicyId"
  type        = "string"
  description = var.davinci_variable_ciam_protectriskpolicyid_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_protectriskpolicyid_value == "" ? null : var.davinci_variable_ciam_protectriskpolicyid_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_protectriskpolicyid_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Account-Recovery-Subflow
resource "davinci_variable" "ciam_recoverylimit" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_recoveryLimit"
  type        = "number"
  description = var.davinci_variable_ciam_recoverylimit_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_recoverylimit_value == "" ? null : var.davinci_variable_ciam_recoverylimit_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_recoverylimit_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Account-Recovery-Subflow
resource "davinci_variable" "ciam_recoveryvalidationattempts" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_recoveryValidationAttempts"
  type        = "number"
  description = var.davinci_variable_ciam_recoveryvalidationattempts_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_recoveryvalidationattempts_value == "" ? null : var.davinci_variable_ciam_recoveryvalidationattempts_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_recoveryvalidationattempts_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_sessionlengthinminute" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_sessionLengthInMinute"
  type        = "number"
  description = var.davinci_variable_ciam_sessionlengthinminute_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_sessionlengthinminute_value == "" ? null : var.davinci_variable_ciam_sessionlengthinminute_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_sessionlengthinminute_value == "" ? true : null

  min = 0
  max = 2000
}

// Flow Name: CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow
resource "davinci_variable" "ciam_smsotpenabled" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_smsOtpEnabled"
  type        = "boolean"
  description = var.davinci_variable_ciam_smsotpenabled_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_smsotpenabled_value == "" ? null : var.davinci_variable_ciam_smsotpenabled_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_smsotpenabled_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Verify-Email-Subflow
resource "davinci_variable" "ciam_verificationlimit" {
  environment_id = var.pingone_environment_id

  context = "company"

  name        = "ciam_verificationLimit"
  type        = "number"
  description = var.davinci_variable_ciam_verificationlimit_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  value = var.davinci_variable_ciam_verificationlimit_value == "" ? null : var.davinci_variable_ciam_verificationlimit_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  
  empty_value = var.davinci_variable_ciam_verificationlimit_value == "" ? true : null

  min = 0
  max = 2000
}

// Flow Name: CIAM-Passwordless-Protect-Verify-Email-Subflow
resource "davinci_variable" "ciam_verificationvalidationattempts" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "ciam_verificationValidationAttempts"
  type        = "number"
  description = var.davinci_variable_ciam_verificationvalidationattempts_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_ciam_verificationvalidationattempts_value == "" ? null : var.davinci_variable_ciam_verificationvalidationattempts_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_ciam_verificationvalidationattempts_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: CIAM-Passwordless-Protect-Threat-Detection-Subflow
resource "davinci_variable" "companyname" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "companyName"
  type        = "string"
  description = var.davinci_variable_companyname_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_companyname_value == "" ? null : var.davinci_variable_companyname_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_companyname_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

// Flow Name: OOTB - Basic Profile Management
resource "davinci_variable" "username" {
  environment_id = var.pingone_environment_id

  context = "flowInstance"

  name        = "username"
  type        = "string"
  description = var.davinci_variable_username_description

  // Defines a static value, but not an empty string.  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // value = var.davinci_variable_username_value == "" ? null : var.davinci_variable_username_value
  
  // Defines a static blank string value ("").  Both `value` and `empty_value` should be null if the variable value should not be tracked in Terraform state.
  // It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.  Uncomment both `value` and `empty_value` to be able to manage a value for this resource.
  // empty_value = var.davinci_variable_username_value == "" ? true : null

  min = 0
  max = 2000

  mutable = true
}

