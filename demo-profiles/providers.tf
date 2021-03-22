terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.1"
    }
  }
}

provider "intersight" {
  apikey    = "insert your key here"
  secretkey = "insert your path here"
  endpoint  = "https://intersight.com"
}