variable "email_address" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "monthly_budget" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//budget?ref=budget-v0.1.0"

  org_code      = var.org_code
  email_address = var.email_address

  usd_limit = 10
}
