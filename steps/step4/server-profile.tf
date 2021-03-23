
resource "intersight_server_profile" "server1" {
  name = "sevt-profile"
  action = "No-op"
  tags {
    key = "owner"
    value = "dchosnek"
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.sevt_org.results[0].moid
  }
  assigned_server {
    moid = "5fd8c3b26176752d30db2c81"
    object_type = "compute.RackUnit"
  }
}

output "profile-moid" {
  value = intersight_server_profile.server1.moid
}