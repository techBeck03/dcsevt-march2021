variable "policy_description" {
    description = "contents of the description field for policies"
    type = string
}

variable "ntp_timezone" {
    type = string
    default = "America/Chicago"
}

# we will use this later
variable "intersight_api_secret" {
  type = string
  default = ""
}
# we will use this later
variable "intersight_api_key" {
  type = string
  default = ""
}
