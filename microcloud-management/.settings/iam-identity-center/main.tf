variable "aws_accounts" {
  type = list(object({
    account_name = string
    account_tier = string
    account_id   = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

module "iam-identity-center" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//iam-identity-center?ref=iam-identity-center/v0.1.0"

  org_abbreviated_name = var.org_abbreviated_name
  aws_accounts         = var.aws_accounts
}
