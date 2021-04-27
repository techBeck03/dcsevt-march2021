
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.7"
    }
  }
}

provider "intersight" {
  apikey = var.intersight_api_key
  secretkey = var.intersight_api_secret
}

