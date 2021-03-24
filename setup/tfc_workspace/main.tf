resource "tfe_workspace" "test" {
#   name         = "sevt-march2021"
  name         = "sevt-testing"
  organization = "Auslab"
}

resource "tfe_variable" "api_key" {
  key          = "intersight_api_key"
  value        = "5b4e48a96a636d6d346cd1bf/5b4e48566a636d6d346ccf6b/605944fb7564612d33d0a9ba"
  category     = "terraform"
  workspace_id = tfe_workspace.test.id
  description  = "Intersight API Key"
  sensitive    = true
}

resource "tfe_variable" "api_secret" {
  key          = "intersight_api_secret"
  value        = file("/Users/robbeck/Downloads/intersight-terraform-key.txt")
  category     = "terraform"
  workspace_id = tfe_workspace.test.id
  description  = "Intersight API Secret"
  sensitive    = true
}

resource "tfe_variable" "api_endpoint" {
  key          = "INTERSIGHT_ENDPOINT_URL"
  value        = "intersight.com"
  category     = "env"
  workspace_id = tfe_workspace.test.id
  description  = "Intersight API Endpoint URL"
}
