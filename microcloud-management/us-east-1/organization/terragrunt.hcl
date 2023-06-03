include "root" {
  path = find_in_parent_folders("main.hcl")
}

terraform {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//organization?ref=organization/v0.0.1"
}

inputs = {
  organizational_unit_prefixes = [
    "shared",
    "dev",
    "stage",
    "prod",
  ]

  organization_operating_regions = [
    "eu-central-1",
    "us-east-1",
  ]
}
