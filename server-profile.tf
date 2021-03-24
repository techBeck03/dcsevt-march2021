
resource "intersight_server_profile" "server1" {
  name = "sevt-profile"
  action = "No-op"
  assigned_server {
    moid = "5fd8c3b26176752d30db2c81"
    object_type = "compute.RackUnit"
  }
  tags {
    key = "owner"
    value = "dchosnek"
  }
  tags {
    key = "location"
    value = "austin"
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.sevt_org.results[0].moid
  }
}

output "profile_moid" {
    value = intersight_server_profile.server1.moid
}