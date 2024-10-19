variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "transit_gateway_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "vpc" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc?ref=vpc-v0.2.0"

  # required variables
  org_code     = var.org_code
  project_code = var.project_code
  env_code     = var.environment_code
  vpc_name     = "main"
  vpc_cidr     = "10.30.0.0/16"

  public_subnets  = ["10.30.0.0/20", "10.30.16.0/20", "10.30.32.0/20"]
  private_subnets = ["10.30.64.0/20", "10.30.80.0/20", "10.30.96.0/20"]
  storage_subnets = ["10.30.128.0/20", "10.30.144.0/20", "10.30.160.0/20"]

  # optional variables
  vpc_flow_logs_s3_bucket_arn = var.vpc_flow_logs_s3_bucket_arn
  domain_name                 = "prod.euw1.anycompany.internal"
  transit_gateway_id          = var.transit_gateway_id

  private_subnets_ingress_nacl = {
    "100" = "10.18.0.0/16", # main vpc eu-west-1 core-prod
    "200" = "10.16.0.0/16", # main vpc us-east-1 core-prod
    "220" = "10.28.0.0/16", # main vpc us-east-1 app-prod
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "tgw_attachment_id" {
  value = module.vpc.tgw_attachment_id
}
