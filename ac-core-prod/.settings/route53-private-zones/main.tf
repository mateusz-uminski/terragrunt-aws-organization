variable "vpcs" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

variable "external_vpcs_prod" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

variable "external_vpcs_dev" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

module "prod_use1_anycompany_internal" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//r53-private-zone?ref=r53-private-zone-v0.1.0"

  # required variables
  zone_name = "use1.prod.anycompany.internal"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_prod
}

output "prod_use1_anycompany_internal_zone_id" {
  value = module.prod_use1_anycompany_internal.zone_id
}

module "prod_euw1_anycompany_internal" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//r53-private-zone?ref=r53-private-zone-v0.1.0"

  # required variables
  zone_name = "euw1.prod.anycompany.internal"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_prod
}

output "prod_euw1_anycompany_internal_zone_id" {
  value = module.prod_euw1_anycompany_internal.zone_id
}

module "dev_use1_anycompany_internal" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//r53-private-zone?ref=r53-private-zone-v0.1.0"

  # required variables
  zone_name = "use1.dev.anycompany.internal"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_dev
}

output "dev_use1_anycompany_internal_zone_id" {
  value = module.dev_use1_anycompany_internal.zone_id
}

module "dev_euw1_anycompany_internal" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//r53-private-zone?ref=r53-private-zone-v0.1.0"

  # required variables
  zone_name = "euw1.dev.anycompany.internal"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_dev
}

output "dev_euw1_anycompany_internal_zone_id" {
  value = module.dev_euw1_anycompany_internal.zone_id
}
