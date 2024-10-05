variable "allowed_account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

module "vpc_flow_logs_bucket" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//logs-bucket?ref=logs-bucket-v0.1.0"

  # required variables
  org_code     = var.org_code
  service_name = "vpc-flow-logs"
  service_addr = "delivery.logs.amazonaws.com"
  account_id   = var.account_id

  # optional variables
  allowed_account_ids = concat([var.account_id], var.allowed_account_ids)
}

output "arn" {
  value = module.vpc_flow_logs_bucket.arn
}

output "name" {
  value = module.vpc_flow_logs_bucket.name
}
