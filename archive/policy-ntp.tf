
# =============================================================================
# NTP Policy
# -----------------------------------------------------------------------------

resource "intersight_ntp_policy" "ntp1" {
  name        = var.ntp_policy_name
  description = var.description
  enabled     = true
  ntp_servers = [
    "172.16.1.90"
    # "172.16.1.91"
  ]
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
  # dynamic "profiles" {
  #   for_each = intersight_server_profile.my_server_profiles
  #   content {
  #     moid        = profiles.value.moid
  #     object_type = "server.Profile"
  #   }
  # }
  tags {
    key   = "owner"
    value = var.owner
  }
  timezone = "America/Chicago"
}

# =============================================================================
# Outputs
# -----------------------------------------------------------------------------

output "policy_ntp" {
  value       = intersight_ntp_policy.ntp1.moid
  description = "NTP policy moid"
}