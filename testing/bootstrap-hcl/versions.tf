terraform {
  required_providers {
    davinci = {
      source  = "pingidentity/davinci"
      version = ">= 0.4.2, < 1.0.0"
    }
    pingone = {
      source  = "pingidentity/pingone"
      version = ">= 1.1.0, < 2.0.0"
    }
  }
}

provider "pingone" {
  # Configuration options
  # Ref: https://registry.terraform.io/providers/pingidentity/pingone/latest/docs#provider-schema-reference

  # Ensure the following environment variables are set:
  # - PINGONE_CLIENT_ID
  # - PINGONE_CLIENT_SECRET
  # - PINGONE_ENVIRONMENT_ID
  # - PINGONE_REGION_CODE
}

provider "davinci" {
  # Configuration options
  # Ref: https://registry.terraform.io/providers/pingidentity/davinci/latest/docs#schema
  
  # Ensure the following environment variables are set:
  # - PINGONE_USERNAME
  # - PINGONE_PASSWORD
  # - TF_VAR_davinci_admin_environment_id
  # - PINGONE_REGION

  environment_id = var.davinci_admin_environment_id
}
