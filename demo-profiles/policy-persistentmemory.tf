# =============================================================================
# Policy - Persistent Memory
# -----------------------------------------------------------------------------

resource "intersight_memory_persistent_memory_policy" "memory1" {
  description = var.description
  management_mode = "configured-from-operating-system"
  name = var.persistentmemory_policy_name
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
}

# =============================================================================
# Outputs
# -----------------------------------------------------------------------------

output "policy_persistentmemory" {
  value       = intersight_memory_persistent_memory_policy.memory1.moid
  description = "Persistent memory policy moid"
}
