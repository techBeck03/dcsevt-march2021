
# =============================================================================
# Intersight Organizations
# -----------------------------------------------------------------------------

data "intersight_organization_organization" "default_organization" {
    name = "default"
}
data "intersight_organization_organization" "infra_organization" {
    name = "Infra"
}

# =============================================================================
# Intersight Roles (IMC)
# -----------------------------------------------------------------------------
# The role defined in the end point which can be assigned to a user.
# This is the built-in role and does not have to be created.
data "intersight_iam_end_point_role" "imc_admin" {
  name      = "admin"
  role_type = "endpoint-admin"
  type      = "IMC"
}
data "intersight_iam_end_point_role" "imc_readonly" {
  name      = "readonly"
  role_type = "endpoint-readonly"
  type      = "IMC"
}