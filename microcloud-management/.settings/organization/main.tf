module "organization" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//organization?ref=organization/v0.0.1"

  organizational_unit_prefixes = [
    "shared",
    "nonprod",
    "prod",
  ]

  organization_operating_regions = [
    "eu-west-1",
    "us-east-1",
  ]
}
