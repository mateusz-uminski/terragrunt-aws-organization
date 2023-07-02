variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "vpc" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc?ref=vpc/v0.3.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  vpc_name             = "main"
  vpc_tier             = "shared"
  vpc_cidr             = "10.16.0.0/16"

  public_subnets  = ["10.16.0.0/20", "10.16.16.0/20", "10.16.32.0/20"]
  private_subnets = ["10.16.64.0/20", "10.16.80.0/20", "10.16.96.0/20"]
  storage_subnets = ["10.16.128.0/20", "10.16.144.0/20", "10.16.160.0/20"]

  # optional variables
  vpc_flow_logs_s3_bucket_arn = var.vpc_flow_logs_s3_bucket_arn

  private_subnets_ingress_nacl = {
    "100" = "10.16.0.0/16", # main vpc us-east-1 shared (current)
    "200" = "10.22.0.0/16", # main vpc us-east-1 nonpprod
    "300" = "10.28.0.0/16", # main vpc us-east-1 prod
  }
}
