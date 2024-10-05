variable "bucket_name" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "allowed_account_ids" {
  type        = list(string)
  description = "Defined in the terragrunt.hcl file."
}

module "cloudtrail" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//cloudtrail?ref=cloudtrail-v0.1.0"

  # required variables
  org_code     = var.org_code
  account_name = var.account_alias

  # optional variables
  allowed_account_ids = concat([var.account_id], var.allowed_account_ids)
  bucket_name         = var.bucket_name
}
