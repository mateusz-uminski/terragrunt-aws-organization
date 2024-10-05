variable "allowed_account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

module "cloudtrail_bucket" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//logs-bucket?ref=logs-bucket-v0.1.0"

  # required variables
  org_code     = var.org_code
  service_name = "cloudtrail"
  service_addr = "cloudtrail.amazonaws.com"
  account_id   = var.account_id

  # optional variables
  allowed_account_ids = concat([var.account_id], var.allowed_account_ids)
}

output "bucket_name" {
  value = module.cloudtrail_bucket.name
}
