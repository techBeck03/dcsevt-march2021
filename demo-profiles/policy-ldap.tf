
# =============================================================================
# Groups (map built-in roles to AD groups)
# -----------------------------------------------------------------------------

# Mapping of LDAP Group to EndPointRoles
resource "intersight_iam_ldap_group" "group1" {
  domain = "auslab.cisco.com"
  end_point_role {
    moid        = data.intersight_iam_end_point_role.imc_admin.moid
    object_type = data.intersight_iam_end_point_role.imc_admin.object_type
  }
  ldap_policy = [{
    additional_properties = ""
    class_id              = ""
    moid                  = intersight_iam_ldap_policy.policy1.moid
    object_type           = ""
    selector              = ""
  }]
  name = "super_admin"
}
resource "intersight_iam_ldap_group" "group2" {
  domain = "auslab.cisco.com"
  end_point_role {
    moid        = data.intersight_iam_end_point_role.imc_readonly.moid
    object_type = data.intersight_iam_end_point_role.imc_readonly.object_type
  }
  ldap_policy = [{
    additional_properties = ""
    class_id              = ""
    moid                  = intersight_iam_ldap_policy.policy1.moid
    object_type           = ""
    selector              = ""
  }]
  name = "Domain Users"
}

# =============================================================================
# Providers (LDAP servers)
# -----------------------------------------------------------------------------

# LDAP Provider or LDAP Server for user authentication.
resource "intersight_iam_ldap_provider" "provider1" {
  ldap_policy = [{
    additional_properties = ""
    class_id              = ""
    moid                  = intersight_iam_ldap_policy.policy1.moid
    object_type           = ""
    selector              = ""
  }]
  port   = 389
  server = "172.16.1.90"
}

resource "intersight_iam_ldap_provider" "provider2" {
  ldap_policy = [{
    additional_properties = ""
    class_id              = ""
    moid                  = intersight_iam_ldap_policy.policy1.moid
    object_type           = ""
    selector              = ""
  }]
  port   = 389
  server = "172.16.1.91"
}

# =============================================================================
# LDAP Policy
# -----------------------------------------------------------------------------

resource "intersight_iam_ldap_policy" "policy1" {
  base_properties = [{
    additional_properties      = ""
    attribute                  = "CiscoAvPair"
    base_dn                    = "dc=auslab,dc=cisco,dc=com"
    bind_dn                    = "" # why is this required?
    bind_method                = "LoginCredentials"
    class_id                   = "" # why is this required?
    domain                     = "auslab.cisco.com"
    enable_encryption          = false
    enable_group_authorization = true
    filter                     = "samAccountName"
    group_attribute            = "memberOf"
    is_password_set            = false
    nested_group_search_depth  = 128
    object_type                = "" # why is this required?
    password                   = "" # why is this required?
    timeout                    = 30
  }]
  description            = var.description
  enable_dns             = false
  enabled                = true
  name                   = var.ldap_policy_name
  user_search_precedence = "LDAPUserDb"
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

output "policy_ldap" {
  value       = intersight_iam_ldap_policy.policy1.moid
  description = "LDAP policy moid"
}
