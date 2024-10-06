module "transit_gateway" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//transit-gateway?ref=transit-gateway-v0.1.0"

  # required variables
  org_code          = var.org_code
  name              = "main"
  asn               = "65020"
  route_table_names = ["use1-euw1", "core-prod", "app-dev", "app-prod"]
}

output "id" {
  value = module.transit_gateway.id
}

output "arn" {
  value = module.transit_gateway.arn
}
