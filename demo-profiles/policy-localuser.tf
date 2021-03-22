
# =============================================================================
# Policy
# -----------------------------------------------------------------------------

# Enables creation of local users on endpoints. This is the actual policy
# that can be viewed in the Intersight UI.
resource "intersight_iam_end_point_user_policy" "user_policy1" {
  description = var.description
  name        = var.localuser_policy_name
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
  password_properties {
    enforce_strong_password  = true
    enable_password_expiry   = false
    force_send_password      = true
    password_expiry_duration = 50
    password_history         = 0
    notification_period      = 15
    grace_period             = 0
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
# User Roles
# -----------------------------------------------------------------------------

# Mapping of endpoint user to endpoint roles.
resource "intersight_iam_end_point_user_role" "roleadmin" {
  enabled = true
  end_point_role {
    moid        = data.intersight_iam_end_point_role.imc_admin.moid
    object_type = data.intersight_iam_end_point_role.imc_admin.object_type
  }
  end_point_user {
    moid        = data.intersight_iam_end_point_user.existing_admin.moid
    object_type = data.intersight_iam_end_point_user.existing_admin.object_type
    # moid        = intersight_iam_end_point_user.admin.moid
    # object_type = intersight_iam_end_point_user.admin.object_type
  }
  end_point_user_policy {
    moid        = intersight_iam_end_point_user_policy.user_policy1.moid
    object_type = intersight_iam_end_point_user_policy.user_policy1.object_type
  }
  password = var.imc_admin_password
}

# =============================================================================
# Local Users
# -----------------------------------------------------------------------------

# Endpoint User or Local User
# resource "intersight_iam_end_point_user" "admin" {
#   name = var.imc_admin_username
#   organization {
#     moid = data.intersight_organization_organization.default_organization.moid
#   }
# }

data "intersight_iam_end_point_user" "existing_admin" {
  name = "admin"
  organization {
    moid = data.intersight_organization_organization.default_organization.moid
  }
}

# =============================================================================
# Outputs
# -----------------------------------------------------------------------------

output "policy_localuser" {
  value       = intersight_iam_end_point_user_policy.user_policy1.moid
  description = "LocalUser policy moid"
}
# output "end_point_user" {
#   value       = intersight_iam_end_point_user.admin.moid
#   description = "End point user"
# }
output "end_point_user_role" {
  value       = intersight_iam_end_point_user_role.roleadmin.moid
  description = "end point user role"
}
