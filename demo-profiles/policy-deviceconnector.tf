
# =============================================================================
# Policy - Device Connector
# -----------------------------------------------------------------------------

resource "intersight_deviceconnector_policy" "dc1" {
  description     = var.description
  lockout_enabled = false
  name            = var.deviceconnector_policy_name
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

output "policy_deviceconnector" {
  value       = intersight_deviceconnector_policy.dc1.moid
  description = "DeviceConnector policy moid"
}
