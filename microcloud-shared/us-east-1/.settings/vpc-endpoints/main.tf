module "s3_main_vpc_endpoint" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc-endpoint?ref=vpc-endpoint/v0.1.1"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  vpc_name             = "mcd-main-vpc-shared"
  vpc_endpoint_name    = "s3-main"
  vpc_endpoint_tier    = "shared"
  aws_service          = "com.amazonaws.${var.region}.s3"

  subnet_names = [
    "mcd-main-private-sn1-shared",
    "mcd-main-private-sn2-shared",
    "mcd-main-private-sn3-shared",
  ]

  # optional variables
  allowed_ingress_cidrs = ["10.0.0.0/8"]
  allowed_ingress_sgs   = [""]
  vpc_endpoint_policy   = ""
}

output "s3_vpc_endpoint_dns_name" {
  value = module.s3_main_vpc_endpoint.regional_dns_name
}
