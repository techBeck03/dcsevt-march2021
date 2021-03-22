# =============================================================================
# Policy - IPMI over LAN
# -----------------------------------------------------------------------------

resource "intersight_ipmioverlan_policy" "ipmi" {
  description = var.description
  enabled     = false
  name        = var.ipmioverlan_policy_name
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
  dynamic "profiles" {
    for_each = intersight_server_profile.my_server_profiles
    content {
      moid        = profiles.value.moid
      object_type = "server.Profile"
    }
  }
  tags {
    key   = "owner"
    value = var.owner
  }
}


# =============================================================================
# Outputs
# -----------------------------------------------------------------------------

output "policy_ipmioverlan" {
  value       = intersight_ipmioverlan_policy.ipmi.moid
  description = "IPMI over LAN policy moid"
}
