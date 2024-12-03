output "pingone_environment_id" {
  value = pingone_environment.test_environment.id
}

output "dv_admin_environment_id" {
  value = var.davinci_admin_environment_id
}

output "pingone_application_client_id" {
  value = pingone_application.davinci_connection.id
}

output "pingone_application_client_secret" {
  value     = pingone_application_secret.davinci_connection.secret
  sensitive = true
}

output "pingone_region_code" {
  value = pingone_environment.test_environment.region
}