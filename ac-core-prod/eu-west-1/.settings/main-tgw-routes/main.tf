variable "vpc_tgw_attachment_id_ac_core_prod" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpc_tgw_attachment_id_ac_app_dev" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpc_tgw_attachment_id_ac_app_prod" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "tgw_peering_attachment_use1_euw1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "main_tgw_routes_ac_core_prod" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes-v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_ac_core_prod
  associate_tgw_rt  = "${var.org_code}-ac-core-prod-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["${var.org_code}-ac-app-dev-tgw-rt", "${var.org_code}-ac-app-prod-tgw-rt"]

  static_routes = [
    { cidr = "10.18.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_core_prod },  # local
    { cidr = "10.16.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-core-prod
    { cidr = "10.22.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-dev
    { cidr = "10.28.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-prod
  ]
}

module "main_tgw_routes_ac_app_dev" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes-v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_ac_app_dev
  associate_tgw_rt  = "${var.org_code}-ac-app-dev-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["${var.org_code}-ac-core-prod-tgw-rt"]

  static_routes = [
    { cidr = "10.24.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_app_dev },    # local
    { cidr = "10.16.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-core-prod
    { cidr = "10.22.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-dev
  ]
}

module "main_tgw_routes_ac_app_prod" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes-v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_ac_app_prod
  associate_tgw_rt  = "${var.org_code}-ac-app-prod-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["${var.org_code}-ac-core-prod-tgw-rt"]

  static_routes = [
    { cidr = "10.30.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_app_prod },   # local
    { cidr = "10.16.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-core-prod
    { cidr = "10.28.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-prod
  ]
}

module "main_tgw_routes_use1_euw1" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes-v0.1.0"

  # required variables
  tgw_attachment_id = var.tgw_peering_attachment_use1_euw1_id
  associate_tgw_rt  = "${var.org_code}-use1-euw1-tgw-rt"

  # optional variables
  static_routes = [
    { cidr = "10.18.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_core_prod },  # eu-west-1 ac-core-prod
    { cidr = "10.24.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_app_dev },    # eu-west-1 ac-app-dev
    { cidr = "10.30.0.0/16", attachment_id = var.vpc_tgw_attachment_id_ac_app_prod },   # eu-west-1 prod
    { cidr = "10.16.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-core-prod
    { cidr = "10.22.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-dev
    { cidr = "10.28.0.0/16", attachment_id = var.tgw_peering_attachment_use1_euw1_id }, # us-east-1 ac-app-prod
  ]
}
