# =============================================================================
# Policy - Boot Precision (boot order)
# -----------------------------------------------------------------------------

resource "intersight_boot_precision_policy" "boot_precision1" {
  name                     = var.bootorder_policy_name
  description              = var.description
  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false
  boot_devices {
    enabled     = true
    name        = var.virtual_disk_name
    object_type = "boot.LocalDisk"
  }
  boot_devices {
    enabled     = true
    name        = var.virtual_dvd_name
    object_type = "boot.VirtualMedia"
  }
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

output "policy_bootprecision" {
  value       = intersight_boot_precision_policy.boot_precision1.moid
  description = "Boot precision policy moid"
}