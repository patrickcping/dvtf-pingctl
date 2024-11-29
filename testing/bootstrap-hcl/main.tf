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
    }
  ]
}

locals {
  pingone_environment_id = pingone_environment.test_environment.id
}