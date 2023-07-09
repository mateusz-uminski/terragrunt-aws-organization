variable "allowed_account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

module "vpc_flow_logs_bucket" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc-flow-logs-bucket?ref=vpc-flow-logs-bucket/v0.1.1"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  account_id           = var.account_id

  # optional variables
  allowed_account_ids = var.allowed_account_ids
}

output "arn" {
  value = module.vpc_flow_logs_bucket.arn
}

output "name" {
  value = module.vpc_flow_logs_bucket.name
}
