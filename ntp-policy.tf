
resource "intersight_ntp_policy" "ntp1" {
  description = var.policy_description
  timezone    = var.ntp_timezone
  name        = "sevt2021-ntp"
  enabled     = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.sevt_org.results[0].moid
  }
  profiles {
    moid = intersight_server_profile.server1.moid
    object_type = "server.Profile"
  }
  tags {
    key = "owner"
    value = "robbeck"
  }
}

output "ntp-policy-moid" {
  value = intersight_ntp_policy.ntp1.moid
}
