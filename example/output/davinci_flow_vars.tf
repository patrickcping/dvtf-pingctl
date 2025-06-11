// Variables for the "CIAM-Passwordless-Protect-Account-Recovery-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_account_recovery_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_account_recovery_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_account_recovery_subflow'."
  default = "CIAM-Passwordless-Protect-Account-Recovery-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_account_recovery_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_account_recovery_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_account_recovery_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_account_recovery_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_account_recovery_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_account_recovery_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_account_recovery_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Account-Registration-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_account_registration_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_account_registration_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_account_registration_subflow'."
  default = "CIAM-Passwordless-Protect-Account-Registration-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_account_registration_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_account_registration_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_account_registration_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_account_registration_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_account_registration_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_account_registration_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_account_registration_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_account_registration_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_account_registration_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_account_registration_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_account_registration_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Agreement(ToS)-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_agreement_tos_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_agreement_tos_subflow'."
  default = "CIAM-Passwordless-Protect-Agreement(ToS)-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_agreement_tos_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_agreement_tos_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_agreement_tos_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_agreement_tos_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_agreement_tos_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Change-Password-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_change_password_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_change_password_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_change_password_subflow'."
  default = "CIAM-Passwordless-Protect-Change-Password-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_change_password_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_change_password_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_change_password_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_change_password_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_change_password_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_change_password_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_change_password_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_change_password_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_change_password_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_change_password_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_change_password_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_change_password_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Device-Authentication-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_device_authentication_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_device_authentication_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_device_authentication_subflow'."
  default = "CIAM-Passwordless-Protect-Device-Authentication-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_device_authentication_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_device_authentication_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:27 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_device_authentication_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_device_authentication_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_device_authentication_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_device_authentication_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_device_authentication_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Device-Registration-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_device_registration_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_device_registration_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_device_registration_subflow'."
  default = "CIAM-Passwordless-Protect-Device-Registration-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_device_registration_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_device_registration_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_device_registration_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_device_registration_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_device_registration_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_device_registration_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_device_registration_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_device_registration_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_device_registration_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_device_registration_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_device_registration_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Magic-Link-Authentication-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_magic_link_authentication_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_magic_link_authentication_subflow'."
  default = "CIAM-Passwordless-Protect-Magic-Link-Authentication-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_magic_link_authentication_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:26 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_magic_link_authentication_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_magic_link_authentication_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_magic_link_authentication_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_magic_link_authentication_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_registration_authentication_account_recovery_main_flow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_registration_authentication_account_recovery_main_flow'."
  default = "CIAM-Passwordless-Protect-Registration-Authentication-Account-Recovery-Main Flow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_registration_authentication_account_recovery_main_flow'."
  default = "Imported on Wed Sep 13 2023 17:10:12 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_registration_authentication_account_recovery_main_flow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_registration_authentication_account_recovery_main_flow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json != null) && (var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_registration_authentication_account_recovery_main_flow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_registration_authentication_account_recovery_main_flow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Threat-Detection-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_threat_detection_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_threat_detection_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_threat_detection_subflow'."
  default = "CIAM-Passwordless-Protect-Threat-Detection-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_threat_detection_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_threat_detection_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:25 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_threat_detection_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_threat_detection_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_threat_detection_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_threat_detection_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_threat_detection_subflow_json_file_path` variable."
  default = null
}
// Variables for the "CIAM-Passwordless-Protect-Verify-Email-Subflow" flow.
// Terraform Resource: davinci_flow.ciam_passwordless_protect_verify_email_subflow

// The Name of the flow
variable "davinci_flow_ciam_passwordless_protect_verify_email_subflow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ciam_passwordless_protect_verify_email_subflow'."
  default = "CIAM-Passwordless-Protect-Verify-Email-Subflow"
  
}

// The Description of the flow
variable "davinci_flow_ciam_passwordless_protect_verify_email_subflow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ciam_passwordless_protect_verify_email_subflow'."
  default = "Imported on Mon Apr 01 2024 07:56:25 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ciam_passwordless_protect_verify_email_subflow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ciam_passwordless_protect_verify_email_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_verify_email_subflow_json` variable."
  default = "assets/flows/ciam_passwordless_protect_verify_email_subflow.json"

  validation {
    condition = (var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path != null || var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json != null) && (var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path == null || var.davinci_flow_ciam_passwordless_protect_verify_email_subflow_json == null)
    error_message = "Must set either 'davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path' or 'davinci_flow_ciam_passwordless_protect_verify_email_subflow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ciam_passwordless_protect_verify_email_subflow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ciam_passwordless_protect_verify_email_subflow'. Cannot be set with the `davinci_flow_ciam_passwordless_protect_verify_email_subflow_json_file_path` variable."
  default = null
}
// Variables for the "OOTB - Basic Profile Management" flow.
// Terraform Resource: davinci_flow.ootb_basic_profile_management

// The Name of the flow
variable "davinci_flow_ootb_basic_profile_management_name" {
  type = string
  
  description = "The name of the flow with resource name 'ootb_basic_profile_management'."
  default = "OOTB - Basic Profile Management"
  
}

// The Description of the flow
variable "davinci_flow_ootb_basic_profile_management_description" {
  type = string
  
  description = "The description of the flow with resource name 'ootb_basic_profile_management'."
  default = "Imported on Wed Sep 13 2023 17:10:34 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ootb_basic_profile_management_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ootb_basic_profile_management_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ootb_basic_profile_management_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ootb_basic_profile_management'. Cannot be set with the `davinci_flow_ootb_basic_profile_management_json` variable."
  default = "assets/flows/ootb_basic_profile_management.json"

  validation {
    condition = (var.davinci_flow_ootb_basic_profile_management_json_file_path != null || var.davinci_flow_ootb_basic_profile_management_json != null) && (var.davinci_flow_ootb_basic_profile_management_json_file_path == null || var.davinci_flow_ootb_basic_profile_management_json == null)
    error_message = "Must set either 'davinci_flow_ootb_basic_profile_management_json_file_path' or 'davinci_flow_ootb_basic_profile_management_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ootb_basic_profile_management_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ootb_basic_profile_management'. Cannot be set with the `davinci_flow_ootb_basic_profile_management_json_file_path` variable."
  default = null
}
// Variables for the "OOTB - Change Password - Subflow - 1" flow.
// Terraform Resource: davinci_flow.ootb_change_password_subflow_1

// The Name of the flow
variable "davinci_flow_ootb_change_password_subflow_1_name" {
  type = string
  
  description = "The name of the flow with resource name 'ootb_change_password_subflow_1'."
  default = "OOTB - Change Password - Subflow - 1"
  
}

// The Description of the flow
variable "davinci_flow_ootb_change_password_subflow_1_description" {
  type = string
  
  description = "The description of the flow with resource name 'ootb_change_password_subflow_1'."
  default = "Cloned on Wed Sep 13 2023 17:45:46 GMT+0000 (Coordinated Universal Time). \nImported on Wed Sep 13 2023 17:10:10 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ootb_change_password_subflow_1_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ootb_change_password_subflow_1_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ootb_change_password_subflow_1_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ootb_change_password_subflow_1'. Cannot be set with the `davinci_flow_ootb_change_password_subflow_1_json` variable."
  default = "assets/flows/ootb_change_password_subflow_1.json"

  validation {
    condition = (var.davinci_flow_ootb_change_password_subflow_1_json_file_path != null || var.davinci_flow_ootb_change_password_subflow_1_json != null) && (var.davinci_flow_ootb_change_password_subflow_1_json_file_path == null || var.davinci_flow_ootb_change_password_subflow_1_json == null)
    error_message = "Must set either 'davinci_flow_ootb_change_password_subflow_1_json_file_path' or 'davinci_flow_ootb_change_password_subflow_1_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ootb_change_password_subflow_1_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ootb_change_password_subflow_1'. Cannot be set with the `davinci_flow_ootb_change_password_subflow_1_json_file_path` variable."
  default = null
}
// Variables for the "OOTB - Device Management - Main Flow" flow.
// Terraform Resource: davinci_flow.ootb_device_management_main_flow

// The Name of the flow
variable "davinci_flow_ootb_device_management_main_flow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ootb_device_management_main_flow'."
  default = "OOTB - Device Management - Main Flow"
  
}

// The Description of the flow
variable "davinci_flow_ootb_device_management_main_flow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ootb_device_management_main_flow'."
  default = "Imported on Wed Sep 13 2023 17:10:40 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ootb_device_management_main_flow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ootb_device_management_main_flow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ootb_device_management_main_flow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ootb_device_management_main_flow'. Cannot be set with the `davinci_flow_ootb_device_management_main_flow_json` variable."
  default = "assets/flows/ootb_device_management_main_flow.json"

  validation {
    condition = (var.davinci_flow_ootb_device_management_main_flow_json_file_path != null || var.davinci_flow_ootb_device_management_main_flow_json != null) && (var.davinci_flow_ootb_device_management_main_flow_json_file_path == null || var.davinci_flow_ootb_device_management_main_flow_json == null)
    error_message = "Must set either 'davinci_flow_ootb_device_management_main_flow_json_file_path' or 'davinci_flow_ootb_device_management_main_flow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ootb_device_management_main_flow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ootb_device_management_main_flow'. Cannot be set with the `davinci_flow_ootb_device_management_main_flow_json_file_path` variable."
  default = null
}
// Variables for the "OOTB - Device Registration - Subflow - 1" flow.
// Terraform Resource: davinci_flow.ootb_device_registration_subflow_1

// The Name of the flow
variable "davinci_flow_ootb_device_registration_subflow_1_name" {
  type = string
  
  description = "The name of the flow with resource name 'ootb_device_registration_subflow_1'."
  default = "OOTB - Device Registration - Subflow - 1"
  
}

// The Description of the flow
variable "davinci_flow_ootb_device_registration_subflow_1_description" {
  type = string
  
  description = "The description of the flow with resource name 'ootb_device_registration_subflow_1'."
  default = "Cloned on Wed Sep 13 2023 17:44:09 GMT+0000 (Coordinated Universal Time). \nImported on Wed Sep 13 2023 17:09:57 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ootb_device_registration_subflow_1_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ootb_device_registration_subflow_1_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ootb_device_registration_subflow_1_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ootb_device_registration_subflow_1'. Cannot be set with the `davinci_flow_ootb_device_registration_subflow_1_json` variable."
  default = "assets/flows/ootb_device_registration_subflow_1.json"

  validation {
    condition = (var.davinci_flow_ootb_device_registration_subflow_1_json_file_path != null || var.davinci_flow_ootb_device_registration_subflow_1_json != null) && (var.davinci_flow_ootb_device_registration_subflow_1_json_file_path == null || var.davinci_flow_ootb_device_registration_subflow_1_json == null)
    error_message = "Must set either 'davinci_flow_ootb_device_registration_subflow_1_json_file_path' or 'davinci_flow_ootb_device_registration_subflow_1_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ootb_device_registration_subflow_1_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ootb_device_registration_subflow_1'. Cannot be set with the `davinci_flow_ootb_device_registration_subflow_1_json_file_path` variable."
  default = null
}
// Variables for the "OOTB - Password Reset - Main Flow" flow.
// Terraform Resource: davinci_flow.ootb_password_reset_main_flow

// The Name of the flow
variable "davinci_flow_ootb_password_reset_main_flow_name" {
  type = string
  
  description = "The name of the flow with resource name 'ootb_password_reset_main_flow'."
  default = "OOTB - Password Reset - Main Flow"
  
}

// The Description of the flow
variable "davinci_flow_ootb_password_reset_main_flow_description" {
  type = string
  
  description = "The description of the flow with resource name 'ootb_password_reset_main_flow'."
  default = "Imported on Wed Sep 13 2023 17:10:38 GMT+0000 (Coordinated Universal Time)"
  
}

// The Log level to apply to the flow
variable "davinci_flow_ootb_password_reset_main_flow_log_level" {
  type = number
  
  description = "An integer that specifies the log level for the flow. Valid values are: `1` (no logging), `2` (info logging - the default set by the service), and `3` (debug logging)."
  default = null

  validation {
    condition     = contains([1, 2, 3], var.davinci_flow_ootb_password_reset_main_flow_log_level)
    error_message = "The value must be one of 1, 2, or 3."
  }
}

// The location of the flow file path
variable "davinci_flow_ootb_password_reset_main_flow_json_file_path" {
  type = string
  
  description = "The filesystem location of the flow JSON with resource name 'ootb_password_reset_main_flow'. Cannot be set with the `davinci_flow_ootb_password_reset_main_flow_json` variable."
  default = "assets/flows/ootb_password_reset_main_flow.json"

  validation {
    condition = (var.davinci_flow_ootb_password_reset_main_flow_json_file_path != null || var.davinci_flow_ootb_password_reset_main_flow_json != null) && (var.davinci_flow_ootb_password_reset_main_flow_json_file_path == null || var.davinci_flow_ootb_password_reset_main_flow_json == null)
    error_message = "Must set either 'davinci_flow_ootb_password_reset_main_flow_json_file_path' or 'davinci_flow_ootb_password_reset_main_flow_json', but not both together."
  }
}

// The raw JSON of the flow
variable "davinci_flow_ootb_password_reset_main_flow_json" {
  type = string
  
  description = "A string representing the raw DaVinci import JSON for resource name 'ootb_password_reset_main_flow'. Cannot be set with the `davinci_flow_ootb_password_reset_main_flow_json_file_path` variable."
  default = null
}
