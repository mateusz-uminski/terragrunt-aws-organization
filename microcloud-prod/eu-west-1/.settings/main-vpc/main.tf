variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "vpc" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc?ref=vpc/v0.3.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  vpc_name             = "main"
  vpc_tier             = "prod"
  vpc_cidr             = "10.30.0.0/16"

  public_subnets  = ["10.30.0.0/20", "10.30.16.0/20", "10.30.32.0/20"]
  private_subnets = ["10.30.64.0/20", "10.30.80.0/20", "10.30.96.0/20"]
  storage_subnets = ["10.30.128.0/20", "10.30.144.0/20", "10.30.160.0/20"]

  # optional variables
  vpc_flow_logs_s3_bucket_arn  = var.vpc_flow_logs_s3_bucket_arn
  private_subnets_ingress_nacl = {}
}
