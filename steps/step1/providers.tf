terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.3"
    }
  }
}

data "intersight_organization_organization" "sevt_org" {
  name = "SEVT2021"
  # moid = "5ddf1d456972652d30bc0a10"
}

output "organization" {
  value = data.intersight_organization_organization.sevt_org.results[0].moid
}