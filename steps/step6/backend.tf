
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "Auslab"

    workspaces {
      name = "sevt-march2021"
    }
  }
}
