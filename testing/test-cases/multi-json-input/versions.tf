terraform {
  required_version = ">= 1.9"

  required_providers {
    davinci = {
      source  = "pingidentity/davinci"
      version = ">= 0.5.0, < 1.0.0"
    }
  }
}
