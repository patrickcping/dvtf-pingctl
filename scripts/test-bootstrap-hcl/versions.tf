terraform {
  required_providers {
    davinci = {
      source  = "pingidentity/davinci"
      version = ">= 0.4.2, < 0.5.0"
    }
    pingone = {
      source  = "pingidentity/pingone"
      version = ">= 1.1.0, < 2.0.0"
    }
  }
}

provider "pingone" {
  # Configuration options
  region_code = "EU"
}

provider "davinci" {
  # Configuration options
  region         = "Europe"
  environment_id = var.pingone_dv_admin_environment_id
}
