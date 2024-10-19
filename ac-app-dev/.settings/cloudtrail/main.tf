variable "cloudtrail_s3_bucket_name" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "cloudtrail" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//cloudtrail?ref=cloudtrail-v0.1.0"

  # required variables
  org_code     = var.org_code
  account_name = var.account_alias

  # optional variables
  allowed_account_ids = []
  bucket_name         = var.cloudtrail_s3_bucket_name
}
