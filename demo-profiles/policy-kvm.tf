
resource "intersight_kvm_policy" "kvmpolicy1" {
  description               = var.description
  enable_local_server_video = true
  enable_video_encryption   = true
  enabled                   = true
  maximum_sessions          = 4
  name                      = var.kvm_policy_name
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
  remote_port = 2068
  tags {
    key   = "owner"
    value = var.owner
  }
}

output "policy_kvm" {
  value       = intersight_kvm_policy.kvmpolicy1.moid
  description = "KVM policy moid"
}
