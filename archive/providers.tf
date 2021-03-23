terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.1"
    }
  }
}

provider "intersight" {
  # apikey    = "5b4e48a96a636d6d346cd1bf/5b4e48566a636d6d346ccf6b/605944fb7564612d33d0a9ba"
  # secretkey = "/Users/dchosnek/Documents/intersight-terraform-key.txt"
  apikey = var.intersight_api_key
  secretkey = var.intersight_api_secret
  endpoint  = "https://intersight.com"
}