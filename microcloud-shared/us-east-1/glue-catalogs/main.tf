variable "account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

variable "cloudtrail_bucket" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpc_flow_logs_bucket" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "aws_service_logs" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//glue-catalogs?ref=glue-catalogs/v0.1.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  database_name        = "aws-service-logs"
  account_ids          = var.account_ids
  regions              = ["us-east-1", "eu-west-1"]

  # optional variables
  cloudtrail_bucket_name    = var.cloudtrail_bucket
  vpc_flow_logs_bucket_name = var.vpc_flow_logs_bucket
}
