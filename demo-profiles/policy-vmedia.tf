# =============================================================================
# Policy - Virtual Media
# -----------------------------------------------------------------------------

resource "intersight_vmedia_policy" "vmedia1" {
  description   = var.description
  enabled       = true
  encryption    = false
  low_power_usb = true
  name          = var.vmedia_policy_name
  mappings = [{
    additional_properties   = ""
    authentication_protocol = "none"
    class_id                = "vmedia.Mapping"
    device_type             = "cdd"
    file_location           = "infra-chx.auslab.cisco.com/software/linux/ubuntu-16.04.6-server-amd64.iso"
    host_name               = "infra-chx.auslab.cisco.com"
    is_password_set         = false
    mount_options           = ""
    mount_protocol          = "nfs"
    object_type             = "vmedia.Mapping"
    password                = ""
    remote_file             = "ubuntu-16.04.6-server-amd64.iso"
    remote_path             = "/iso/software/linux"
    sanitized_file_location = "infra-chx.auslab.cisco.com/software/linux/ubuntu-16.04.6-server-amd64.iso"
    username                = ""
    volume_name             = var.virtual_dvd_name
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

output "policy_vmedia" {
  value       = intersight_vmedia_policy.vmedia1.moid
  description = "vMedia policy moid"
}
