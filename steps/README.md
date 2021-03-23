# Step 1: setup and verify environment

## Get the provider template

Copy the following from "use provider" dropdown on the Terraform Registry page for Intersight and save it in a file called `providers.tf`.
```
terraform {
  required_providers {
    intersight = {
      source = "CiscoDevNet/intersight"
      version = "1.0.3"
    }
  }
}

provider "intersight" {
  # Configuration options
}
```

## Add your credentials

Your API credentials must be in the `provider "intersight"` block or saved as environment variables.

```
provider "intersight" {
  apikey    = "insert your key here"
  secretkey = "insert the path to a file containing your secret"
  endpoint  = "intersight.com"
}
```

Alternately, you can save this same data as environment variables and eleminate the block above from your configuration files completely.
* INTERSIGHT_API_KEY
* INTERSIGHT_SECRET_KEY
* INTERSIGHT_ENDPOINT_URL

## Read some data (organization)

To verify that the settings all work, read some data from Intersight using a data source. Add this to the `providers.tf` file:

```
data "intersight_organization_organization" "sevt_org" {
  name = "SEVT2021"
}
```
The following output statement is optional but can be helpful for visibility. It will display the `moid` of the organization when the Terraform configuration is applied.
```
output "organization" {
  value = data.intersight_organization_organization.sevt_org.results[0].moid
}
```
## terraform init and apply

Run `terraform init` to download the provider locally.

Run `terraform apply` to apply the specified Terraform configuration, which in this case will only retrieve an existing organization.


# Step 2: create an NTP policy

## Split into multiple files

Create a file called `sources.tf` and move the block for retrieving the existing organization to that file. This step is not required, but it is good to start practicing good code organization.

Create a file called `ntp-policy.tf`. Find the sample for the NTP policy block in the TF registry documentation [here](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/ntp_policy). 

One thing must change from the sample in the documentation. Provide the `moid` for the organization that we retrieved in an earlier step as shown below.

```
resource "intersight_ntp_policy" "ntp1" {
  name    = "ntp1"
  enabled = true
  ntp_servers = [
    "ntp.esl.cisco.com",
    "time-a-g.nist.gov",
    "time-b-g.nist.gov"
  ]
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.sevt_org.results[0].moid
  }
}
```
Additional fields can be added to the NTP policy like `description` and `timezone`. They are not required. Always check the documentation for optional fields.

Output blocks can be helpful but are not required.
```
output "ntp-policy-moid" {
  value = intersight_ntp_policy.ntp1.moid
}
```

# Step 3: using variables

It is a good idea to start implementing variables before the configuration gets too large. Create a file called `variables.tf` which will contain the **definitions** for all the variables.

```
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
```

Create a file called `terraform.tfvars` which will contain the **values** to be used for those variables. This file has one variable per line in any order. Variables can be specified in other files with any name that follows the format `*.auto.tfvars`.

```
policy_description = "Created by Terraform. Do not edit manually."
ntp_timezone = "America/Chicago"
```

Now add a variable to the NTP policy definition. Edit the file `ntp-policy.tf` and add these two lines to the resource block for the NTP policy:

```
description = var.policy_description
timezone    = var.ntp_timezone
```

Execute `terraform apply` and ensure the NTP policy has a new description and the appropriate timezone.