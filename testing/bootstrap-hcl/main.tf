resource "pingone_environment" "test_environment" {
  name       = format("DVTF-PINGCTL Test Environment - %s", var.test_name)
  type       = "SANDBOX"
  license_id = var.license_id

  services = [
    {
      type = "SSO"
    },
    {
      type = "DaVinci",
      tags = ["DAVINCI_MINIMAL"]
    },
    {
      type = "MFA"
    },
    {
      type = "Risk"
    },
  ]
}

resource "pingone_application" "davinci_connection" {
  environment_id = pingone_environment.test_environment.id

  name        = "PingOne DaVinci Connection"
  description = "The built-in application used by PingOne connectors in DaVinci to retrieve and manage profile details, passwords, and agreement consent, as well as handle risk evaluations and multi-factor authentication (MFA)."
  enabled     = true

  access_control_role_type = "ADMIN_USERS_ONLY"
  hidden_from_app_portal   = false
  icon = {
    href = "https://assets.pingone.com/ux/ui-library/4.18.0/images/logo-pingidentity.png"
    id   = "0b3f4512-aab3-4d01-8417-4076dc4945ea"
  }

  oidc_options = {
    additional_refresh_token_replay_protection_enabled = true
    device_polling_interval                            = 5
    device_timeout                                     = 600
    grant_types                                        = ["CLIENT_CREDENTIALS"]
    par_requirement                                    = "OPTIONAL"
    par_timeout                                        = 60
    pkce_enforcement                                   = "OPTIONAL"
    token_endpoint_auth_method                         = "CLIENT_SECRET_BASIC"
    type                                               = "WORKER"
  }
}

resource "time_rotating" "application_secret_rotation" {
  rotation_days = 30
}

resource "pingone_application_secret" "davinci_connection" {
  environment_id = pingone_environment.test_environment.id
  application_id = pingone_application.davinci_connection.id

  regenerate_trigger_values = {
    "rotation_rfc3339" : time_rotating.application_secret_rotation.rotation_rfc3339,
  }
}

locals {
  admin_roles = [
    "DaVinci Admin",
    "Environment Admin",
    "Identity Data Admin"
  ]
}

data "pingone_role" "admin_role" {
  for_each = toset(local.admin_roles)
  name     = each.key
}

resource "pingone_application_role_assignment" "role_assignment_to_davinci_connection" {
  for_each = toset(local.admin_roles)

  environment_id = pingone_environment.test_environment.id
  application_id = pingone_application.davinci_connection.id
  role_id        = data.pingone_role.admin_role[each.key].id

  scope_environment_id = pingone_environment.test_environment.id
}