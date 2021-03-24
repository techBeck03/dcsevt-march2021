resource "intersight_smtp_policy" "sevt2021_labadmins" {
  name         = "sevt2021-snmp"
  description  = "SMTP policy for sevt2021"
  enabled      = true
  min_severity = "critical"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.sevt_org.results[0].moid
  }
  smtp_server     = "smtp-ext.cisco.com"
  smtp_port       = 25
  sender_email    = "example-email@cisco.com"
  smtp_recipients = ["example-email@cisco.com"]
}
