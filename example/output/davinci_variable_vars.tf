// Variables for the "agreementId" variable, with context flowInstance.
// Terraform Resource: davinci_variable.agreementid

// The value of the variable

variable "davinci_variable_agreementid_value" {
  type = string
  sensitive = false
  
  description = "The value of the variable with resource name 'agreementid'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "29d5d681-93ee-4590-abdc-7d7cd94aa85c"
 }

// The description of the variable
variable "davinci_variable_agreementid_description" {
  type = string
  
  description = "The description of the variable with resource name 'agreementid'."
  default = null
}
// Variables for the "ciam_accountRecoveryEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_accountrecoveryenabled

// The value of the variable

variable "davinci_variable_ciam_accountrecoveryenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_accountrecoveryenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_accountrecoveryenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_accountrecoveryenabled'."
  default = null
}
// Variables for the "ciam_agreementEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_agreementenabled

// The value of the variable

variable "davinci_variable_ciam_agreementenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_agreementenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "false"
 }

// The description of the variable
variable "davinci_variable_ciam_agreementenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_agreementenabled'."
  default = null
}
// Variables for the "ciam_appleEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_appleenabled

// The value of the variable

variable "davinci_variable_ciam_appleenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_appleenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_appleenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_appleenabled'."
  default = null
}
// Variables for the "ciam_authMethod" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_authmethod

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_authmethod resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_authmethod_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_authmethod'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_authmethod_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_authmethod'."
  default = null
}
// Variables for the "ciam_companyName" variable, with context company.
// Terraform Resource: davinci_variable.ciam_companyname

// The value of the variable

variable "davinci_variable_ciam_companyname_value" {
  type = string
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_companyname'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "Ping Identity"
 }

// The description of the variable
variable "davinci_variable_ciam_companyname_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_companyname'."
  default = null
}
// Variables for the "ciam_deviceId" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_deviceid

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_deviceid resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_deviceid_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_deviceid'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_deviceid_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_deviceid'."
  default = null
}
// Variables for the "ciam_emailOtpEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_emailotpenabled

// The value of the variable

variable "davinci_variable_ciam_emailotpenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_emailotpenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_emailotpenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_emailotpenabled'."
  default = null
}
// Variables for the "ciam_errorMessage" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_errormessage

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_errormessage resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_errormessage_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_errormessage'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_errormessage_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_errormessage'."
  default = null
}
// Variables for the "ciam_facebookEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_facebookenabled

// The value of the variable

variable "davinci_variable_ciam_facebookenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_facebookenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_facebookenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_facebookenabled'."
  default = null
}
// Variables for the "ciam_fidoPasskeyEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_fidopasskeyenabled

// The value of the variable

variable "davinci_variable_ciam_fidopasskeyenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_fidopasskeyenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_fidopasskeyenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_fidopasskeyenabled'."
  default = null
}
// Variables for the "ciam_googleEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_googleenabled

// The value of the variable

variable "davinci_variable_ciam_googleenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_googleenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_googleenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_googleenabled'."
  default = null
}
// Variables for the "ciam_logoStyle" variable, with context company.
// Terraform Resource: davinci_variable.ciam_logostyle

// The value of the variable

variable "davinci_variable_ciam_logostyle_value" {
  type = string
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_logostyle'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "width: 65px; height: 65px;"
 }

// The description of the variable
variable "davinci_variable_ciam_logostyle_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_logostyle'."
  default = "CSS style for company logo"
  
}
// Variables for the "ciam_logoUrl" variable, with context company.
// Terraform Resource: davinci_variable.ciam_logourl

// The value of the variable

variable "davinci_variable_ciam_logourl_value" {
  type = string
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_logourl'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "https://assets.pingone.com/ux/ui-library/5.0.2/images/logo-pingidentity.png"
 }

// The description of the variable
variable "davinci_variable_ciam_logourl_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_logourl'."
  default = "URL of company logo"
  
}
// Variables for the "ciam_magicLinkEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_magiclinkenabled

// The value of the variable

variable "davinci_variable_ciam_magiclinkenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_magiclinkenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_magiclinkenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_magiclinkenabled'."
  default = null
}
// Variables for the "ciam_passwordlessRequired" variable, with context company.
// Terraform Resource: davinci_variable.ciam_passwordlessrequired

// The value of the variable

variable "davinci_variable_ciam_passwordlessrequired_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_passwordlessrequired'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "false"
 }

// The description of the variable
variable "davinci_variable_ciam_passwordlessrequired_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_passwordlessrequired'."
  default = null
}
// Variables for the "ciam_protectDeviceStatus" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_protectdevicestatus

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_protectdevicestatus resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_protectdevicestatus_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_protectdevicestatus'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_protectdevicestatus_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_protectdevicestatus'."
  default = "Used by CIAM Passwordless and PingOne protect flow"
  
}
// Variables for the "ciam_protectPredictor" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_protectpredictor

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_protectpredictor resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_protectpredictor_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_protectpredictor'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_protectpredictor_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_protectpredictor'."
  default = "Used by CIAM Passwordless and PingOne Protect flows."
  
}
// Variables for the "ciam_protectRiskID" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_protectriskid

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_protectriskid resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_protectriskid_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_protectriskid'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_protectriskid_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_protectriskid'."
  default = "This variable is used by CIAM Passwordless with pingone protect flows."
  
}
// Variables for the "ciam_protectRiskLevel" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_protectrisklevel

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_protectrisklevel resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_protectrisklevel_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_protectrisklevel'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_protectrisklevel_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_protectrisklevel'."
  default = "Used by CIAM Passwordless and PingOne protect flows"
  
}
// Variables for the "ciam_protectriskPolicyId" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_protectriskpolicyid

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_protectriskpolicyid resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_protectriskpolicyid_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_protectriskpolicyid'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_protectriskpolicyid_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_protectriskpolicyid'."
  default = "This PingOne Protect Risk Policy ID will be passed by default."
  
}
// Variables for the "ciam_recoveryLimit" variable, with context company.
// Terraform Resource: davinci_variable.ciam_recoverylimit

// The value of the variable

variable "davinci_variable_ciam_recoverylimit_value" {
  type = number
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_recoverylimit'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "5"
 }

// The description of the variable
variable "davinci_variable_ciam_recoverylimit_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_recoverylimit'."
  default = null
}
// Variables for the "ciam_recoveryValidationAttempts" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_recoveryvalidationattempts

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_recoveryvalidationattempts resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_recoveryvalidationattempts_value" {
//   type = number
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_recoveryvalidationattempts'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_recoveryvalidationattempts_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_recoveryvalidationattempts'."
  default = null
}
// Variables for the "ciam_sessionLengthInMinute" variable, with context company.
// Terraform Resource: davinci_variable.ciam_sessionlengthinminute

// The value of the variable

variable "davinci_variable_ciam_sessionlengthinminute_value" {
  type = number
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_sessionlengthinminute'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "5"
 }

// The description of the variable
variable "davinci_variable_ciam_sessionlengthinminute_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_sessionlengthinminute'."
  default = null
}
// Variables for the "ciam_smsOtpEnabled" variable, with context company.
// Terraform Resource: davinci_variable.ciam_smsotpenabled

// The value of the variable

variable "davinci_variable_ciam_smsotpenabled_value" {
  type = bool
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_smsotpenabled'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "true"
 }

// The description of the variable
variable "davinci_variable_ciam_smsotpenabled_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_smsotpenabled'."
  default = null
}
// Variables for the "ciam_verificationLimit" variable, with context company.
// Terraform Resource: davinci_variable.ciam_verificationlimit

// The value of the variable

variable "davinci_variable_ciam_verificationlimit_value" {
  type = number
  sensitive = false
  
  description = "The value of the variable with resource name 'ciam_verificationlimit'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
  default = "5"
 }

// The description of the variable
variable "davinci_variable_ciam_verificationlimit_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_verificationlimit'."
  default = null
}
// Variables for the "ciam_verificationValidationAttempts" variable, with context flowInstance.
// Terraform Resource: davinci_variable.ciam_verificationvalidationattempts

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.ciam_verificationvalidationattempts resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_ciam_verificationvalidationattempts_value" {
//   type = number
//   sensitive = false
  
//   description = "The value of the variable with resource name 'ciam_verificationvalidationattempts'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_ciam_verificationvalidationattempts_description" {
  type = string
  
  description = "The description of the variable with resource name 'ciam_verificationvalidationattempts'."
  default = null
}
// Variables for the "companyName" variable, with context flowInstance.
// Terraform Resource: davinci_variable.companyname

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.companyname resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_companyname_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'companyname'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_companyname_description" {
  type = string
  
  description = "The description of the variable with resource name 'companyname'."
  default = null
}
// Variables for the "username" variable, with context flowInstance.
// Terraform Resource: davinci_variable.username

// The value of the variable
// It is expected the value will be set by the DaVinci flows during runtime, and should not be managed by Terraform.
// Uncomment this variable, and the `value` and `empty_value` fields in the davinci_variable.username resource to be able to manage a value for this resource in Terraform.
// If managing a variable value in Terraform that is also managed by DaVinci flows at runtime, Terraform will continually detect drift and may cause disruption to users at runtime.
// variable "davinci_variable_username_value" {
//   type = string
//   sensitive = false
  
//   description = "The value of the variable with resource name 'username'.  Set to null to ensure the variable value doesn't get tracked in Terraform state (e.g., when using variables that flows manage the values for)."
//   default = null
//  }

// The description of the variable
variable "davinci_variable_username_description" {
  type = string
  
  description = "The description of the variable with resource name 'username'."
  default = null
}
