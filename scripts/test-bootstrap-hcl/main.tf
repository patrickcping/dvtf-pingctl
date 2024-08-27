resource "pingone_environment" "my_environment" {
  name       = "DVTF-PINGCTL Test Environment"
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
  pingone_environment_id = pingone_environment.my_environment.id
}