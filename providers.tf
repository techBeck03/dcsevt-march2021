terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.1"
    }
  }
}

provider "intersight" {
  # apikey    = "5b4e48a96a636d6d346cd1bf/5b4e48566a636d6d346ccf6b/602b10b67564612d333763f0"
  # secretkey = "/Users/dchosnek/Documents/intersight-terraform-key.txt"
  secretkey = var.intersight_api_secret
  endpoint  = "https://intersight.com"
}