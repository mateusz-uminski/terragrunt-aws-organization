variable "allowed_account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

module "cloudtrail" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//cloudtrail?ref=cloudtrail/v0.1.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  account_name         = var.account_name

  # optional variables
  allowed_account_ids = concat([var.account_id], var.allowed_account_ids)
  bucket_name         = ""
}

output "bucket_name" {
  value = module.cloudtrail.bucket_name
}
