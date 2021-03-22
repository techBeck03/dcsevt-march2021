# =============================================================================
# Policy - Disk Group Policy
# -----------------------------------------------------------------------------

# create a RAID mirror between the first two physical disks

resource "intersight_storage_disk_group_policy" "group1" {
  description = var.description
  name        = var.diskgroup_policy_name
  raid_level  = "Raid1"
  span_groups = [{
    additional_properties = ""
    class_id              = "storage.LocalDisk"
    disks = [{
      additional_properties = ""
      class_id              = "storage.LocalDisk"
      object_type           = "storage.LocalDisk"
      slot_number           = 2
      },
      {
        additional_properties = ""
        class_id              = "storage.LocalDisk"
        object_type           = "storage.LocalDisk"
        slot_number           = 3
      }
    ]
    object_type = "storage.SpanGroup"
  }]
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
  tags {
    key   = "owner"
    value = var.owner
  }
}

# policy that uses the RAID mirror to create a virtual disk called vd0

resource "intersight_storage_storage_policy" "storage1" {
  description = var.description
  disk_group_policies = [{
    additional_properties = ""
    moid                  = intersight_storage_disk_group_policy.group1.moid
    class_id              = ""
    object_type           = "storage.DiskGroupPolicy"
    selector              = ""
  }]
  #   global_hot_spares = [ ]
  name                         = var.storage_policy_name
  retain_policy_virtual_drives = false
  unused_disks_state           = "UnconfiguredGood"
  virtual_drives = [{
    access_policy         = "Default"
    additional_properties = ""
    boot_drive            = false
    class_id              = "storage.VirtualDriveConfig"
    disk_group_name       = intersight_storage_disk_group_policy.group1.name
    disk_group_policy     = intersight_storage_disk_group_policy.group1.moid
    drive_cache           = "Default"
    expand_to_available   = true
    io_policy             = "Default"
    name                  = var.virtual_disk_name
    object_type           = "storage.VirtualDriveConfig"
    read_policy           = "Default"
    size                  = 0
    strip_size            = "Default"
    vdid                  = "value"
    write_policy          = "Default"
  }]
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

output "policy_diskgroup" {
  value       = intersight_storage_disk_group_policy.group1.moid
  description = "Disk group moid"
}
output "policy_storage" {
  value       = intersight_storage_storage_policy.storage1.moid
  description = "Storage policy moid"
}
