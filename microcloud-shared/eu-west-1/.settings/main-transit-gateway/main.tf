module "transit_gateway" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//transit-gateway?ref=transit-gateway/v0.1.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  name                 = "main"
  asn                  = "65020"
  route_table_names    = ["ue1-ew1", "shared", "nonprod", "prod"]
}

output "id" {
  value = module.transit_gateway.id
}

output "arn" {
  value = module.transit_gateway.arn
}
