

# =============================================================================
# Profiles
# -----------------------------------------------------------------------------

resource "intersight_server_profile" "my_server_profiles" {
  for_each = var.server_list
  assigned_server {
      moid        = each.value
      object_type = "compute.RackUnit"
  }
  # action = "Deploy"
  action = "No-op"
  description = var.description
  name = each.key
  organization {
      moid = data.intersight_organization_organization.default_organization.moid
  }
  tags {
    key   = "owner"
    value = var.owner
  }
}

# =============================================================================
# Outputs
# -----------------------------------------------------------------------------

output "all_profiles" {
  value       = values(intersight_server_profile.my_server_profiles)[*].moid
  description = "The Moids for all server profiles"
}