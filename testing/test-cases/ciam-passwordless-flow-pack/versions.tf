terraform {
  required_version = ">= 1.1"

  required_providers {
    davinci = {
      source  = "pingidentity/davinci"
      version = ">= 0.4.2, < 1.0.0"
    }
  }
}
