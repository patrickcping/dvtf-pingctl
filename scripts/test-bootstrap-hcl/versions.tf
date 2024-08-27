terraform {
  required_providers {
    davinci = {
      source = "pingidentity/davinci"
      version = "0.4.2"
    }
    pingone = {
      source = "pingidentity/pingone"
      version = "1.1.0"
    }
  }
}

provider "pingone" {
  # Configuration options
  region_code = "EU"
}

provider "davinci" {
  # Configuration options
  region = "Europe"
}