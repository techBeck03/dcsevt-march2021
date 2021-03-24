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
Execute `terraform apply` and ensure the NTP policy was created.

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

Create a file called `sevt.auto.tfvars` which will contain the **values** to be used for those variables. This file has one variable per line in any order. Variables can be specified in other files with any name that follows the format `*.auto.tfvars`.

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

# Step 4: Create a server profile and map the policy

Create a file called `server-profile.tf` and add the sample code found in the [documentation](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/server_profile).

Make a few modifications:
* give the profile a better name
* give the profile some kind of tag
* update the organization to be the organization located in the very first step

```
resource "intersight_server_profile" "server1" {
  name = "server1"
  action = "No-op"
  tags {
    key = "server"
    value = "demo"
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.sevt_org.results[0].moid
  }
}
```

An optional output block can be used to display the created server profile.

```
output "profile-moid" {
  value = intersight_server_profile.server1.moid
}
```
Execute `terraform apply` and ensure the profile was created. Note that the profile has no policies assigned to it.

Edit the file `ntp-policy.tf` and add the following block to the policy definition. This will assign the NTP policy to the server profile that was just created.

```
profiles {
    moid = intersight_server_profile.server1.moid
    object_type = "server.Profile"
  }
```
Execute `terraform apply` and ensure the profile now has the NTP policy assigned to it.

The profile is still not assigned to a server, though. Locate the `moid` for an available server and update the server profile definition in `server-profile.tf` with the following. Note that the field that should be added is **assigned server** and not *associated* server. The `moid` and `object_type` are the only parameters required.

```
assigned_server {
  moid = "5fd8c3b26176752d30db2c81"
  object_type = "compute.RackUnit"
}
```
Execute `terraform apply` and ensure the profile is now assigned to a physical server.

# Step 5: Transfer your state remotely

For this portion, you will need a Terraform Cloud account to reproduce what is being shown live. You should have a local state file at this time. We will be transferring that state to Terraform Cloud.

Create a file named `backend.tf` with the following contents (replacing the organization name and workspace name with your own).

```
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Auslab"

    workspaces {
      name = "sevt-march2021"
    }
  }
}
```

Add configuration parameters to your `providers.tf` file as shown below. 
```
provider "intersight" {
  apikey    = var.intersight_api_key
  secretkey = var.intersight_api_secret
  endpoint  = "intersight.com"
}
```
Variables for the API key and API secret should already be created in Terraform Cloud. Ensure that any variable in the configuration files that does not have a default is also created in Terraform Cloud.

Execute `terraform init` and notice the request to transfer your state remotely. Answer yes. From this point forward, Terraform Cloud executes your desired state and manages your state file.

**Remove your local state file** as state is now managed by Terraform Cloud. The presence of the local state file will interfere with any attempts to update your configuration locally.
