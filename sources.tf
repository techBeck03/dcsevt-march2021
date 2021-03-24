
data "intersight_organization_organization" "sevt_org" {
    name = "SEVT2021"
}

output "organization" {
    value = data.intersight_organization_organization.sevt_org.results[0].moid
}
