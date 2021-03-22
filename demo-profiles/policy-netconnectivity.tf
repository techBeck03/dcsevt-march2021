
# =============================================================================
# Policy - Network Connectivity
# -----------------------------------------------------------------------------

# IPv6 is enabled because this is the only way that the provider allows the
# IPv6 DNS servers (primary and alternate) to be set to something. If it is not
# set to something other than null in this resource, then terraform "apply"
# will detect that thare changes to apply every time ("::" -> null).

resource "intersight_networkconfig_policy" "connectivity1" {
  alternate_ipv4dns_server = "172.16.1.90"
  # alternate_ipv6dns_server = "::"
  description              = var.description
  enable_dynamic_dns       = false
  enable_ipv4dns_from_dhcp = false
  enable_ipv6              = false
  enable_ipv6dns_from_dhcp = false
  name                     = var.netconnectivity_policy_name
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
  preferred_ipv4dns_server = "172.16.1.98"
  # preferred_ipv6dns_server = "::"
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

output "policy_netconnectivity" {
  value       = intersight_networkconfig_policy.connectivity1.moid
  description = "KVM policy moid"
}
