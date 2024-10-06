variable "transit_gateway_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "principal" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "tgw_nonprod_sharing" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//resource-share?ref=resource-share-v0.1.0"

  # required variables
  org_code     = var.org_code
  name         = "main-tgw-nonprod"
  resource_arn = var.transit_gateway_arn
  principal    = var.principal
}

output "arn" {
  value = module.tgw_nonprod_sharing.arn
}
