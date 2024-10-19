module "s3_main_vpc_endpoint" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc-endpoint?ref=vpc-endpoint-v0.1.2"

  # required variables
  org_code          = var.org_code
  env_code          = "prod"
  vpc_name          = "ac-main-vpc-prod"
  vpc_endpoint_name = "s3-main"
  aws_service       = "com.amazonaws.${var.region_name}.s3"

  subnet_names = [
    "ac-main-private-sn1-prod",
    "ac-main-private-sn2-prod",
    "ac-main-private-sn3-prod",
  ]

  # optional variables
  allowed_ingress_cidrs = ["10.0.0.0/8"]
  allowed_ingress_sgs   = [""]
  vpc_endpoint_policy   = ""
}

output "s3_vpc_endpoint_dns_name" {
  value = module.s3_main_vpc_endpoint.regional_dns_name
}
