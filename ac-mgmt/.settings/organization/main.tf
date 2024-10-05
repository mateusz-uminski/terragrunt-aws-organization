module "organization" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//organization?ref=organization-v0.1.0"

  unit_prefixes = [
    "dev",
    "prod",
  ]

  operating_regions = [
    "eu-west-1",
    "us-east-1",
  ]
}
