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

module "ue1_shared_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ue1.shared.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = merge(var.external_vpcs_prod, var.external_vpcs_dev)
}

module "ew1_shared_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ew1.shared.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = merge(var.external_vpcs_prod, var.external_vpcs_dev)
}

module "ue1_prod_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ue1.prod.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_prod
}

module "ew1_prod_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ew1.prod.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_prod
}

module "ue1_dev_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ue1.dev.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_dev
}

module "ew1_dev_corp_microcloud_com" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//route53-private-zone?ref=route53-private-zone/v0.1.0"

  # required variables
  zone_name = "ew1.dev.corp.microcloud.com"
  vpcs      = var.vpcs

  # optional variables
  external_vpcs = var.external_vpcs_dev
}

output "ue1_shared_corp_microcloud_com_zone_id" {
  value = module.ue1_shared_corp_microcloud_com.zone_id
}

output "ew1_pshared_corp_microcloud_com_zone_id" {
  value = module.ew1_shared_corp_microcloud_com.zone_id
}

output "ue1_prod_corp_microcloud_com_zone_id" {
  value = module.ue1_prod_corp_microcloud_com.zone_id
}

output "ew1_prod_corp_microcloud_com_zone_id" {
  value = module.ew1_prod_corp_microcloud_com.zone_id
}

output "ue1_dev_corp_microcloud_com_zone_id" {
  value = module.ue1_dev_corp_microcloud_com.zone_id
}

output "ew1_dev_corp_microcloud_com_zone_id" {
  value = module.ew1_dev_corp_microcloud_com.zone_id
}
