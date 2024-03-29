variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "transit_gateway_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "vpc" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc?ref=vpc/v0.5.2"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  vpc_name             = "main"
  vpc_tier             = "prod"
  vpc_cidr             = "10.28.0.0/16"

  public_subnets  = ["10.28.0.0/20", "10.28.16.0/20", "10.28.32.0/20"]
  private_subnets = ["10.28.64.0/20", "10.28.80.0/20", "10.28.96.0/20"]
  storage_subnets = ["10.28.128.0/20", "10.28.144.0/20", "10.28.160.0/20"]

  # optional variables
  vpc_flow_logs_s3_bucket_arn = var.vpc_flow_logs_s3_bucket_arn
  domain_name                 = "ue1.prod.corp.microcloud.com"
  transit_gateway_id          = var.transit_gateway_id

  private_subnets_ingress_nacl = {
    "100" = "10.16.0.0/16", # main vpc us-east-1 shared
    "200" = "10.18.0.0/16", # main vpc eu-west-1 shared
    "220" = "10.30.0.0/16", # main vpc eu-west-1 prod
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "tgw_attachment_id" {
  value = module.vpc.tgw_attachment_id
}
