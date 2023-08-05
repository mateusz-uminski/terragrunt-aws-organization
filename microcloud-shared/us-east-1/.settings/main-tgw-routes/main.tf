variable "vpc_tgw_attachment_id_shared" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpc_tgw_attachment_id_nonprod" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpc_tgw_attachment_id_prod" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "tgw_peering_attachment_ue1_ew1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

module "main_tgw_routes_shared" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes/v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_shared
  associate_tgw_rt  = "mcd-shared-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["mcd-nonprod-tgw-rt", "mcd-prod-tgw-rt"]

  static_routes = [
    { cidr = "10.16.0.0/16", attachment_id = var.vpc_tgw_attachment_id_shared },      # local
    { cidr = "10.18.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 shared
    { cidr = "10.24.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 nonprod
    { cidr = "10.30.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 prod
  ]
}

module "main_tgw_routes_nonprod" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes/v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_nonprod
  associate_tgw_rt  = "mcd-nonprod-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["mcd-shared-tgw-rt"]

  static_routes = [
    { cidr = "10.22.0.0/16", attachment_id = var.vpc_tgw_attachment_id_nonprod },     # local
    { cidr = "10.18.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 shared
    { cidr = "10.24.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 nonprod
  ]
}

module "main_tgw_routes_prod" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes/v0.1.0"

  # required variables
  tgw_attachment_id = var.vpc_tgw_attachment_id_prod
  associate_tgw_rt  = "mcd-prod-tgw-rt"

  # optional variables
  propagate_tgw_rt = ["mcd-shared-tgw-rt"]

  static_routes = [
    { cidr = "10.28.0.0/16", attachment_id = var.vpc_tgw_attachment_id_prod },        # local
    { cidr = "10.18.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 shared
    { cidr = "10.30.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 prod
  ]
}

module "main_tgw_routes_ue1_ew1" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//tgw-routes?ref=tgw-routes/v0.1.0"

  # required variables
  tgw_attachment_id = var.tgw_peering_attachment_ue1_ew1_id
  associate_tgw_rt  = "mcd-ue1-ew1-tgw-rt"

  # optional variables
  static_routes = [
    { cidr = "10.16.0.0/16", attachment_id = var.vpc_tgw_attachment_id_shared },      # us-east-1 shared
    { cidr = "10.22.0.0/16", attachment_id = var.vpc_tgw_attachment_id_nonprod },     # us-east-1 nonprod
    { cidr = "10.28.0.0/16", attachment_id = var.vpc_tgw_attachment_id_prod },        # us-east-1 prod
    { cidr = "10.18.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 shared
    { cidr = "10.24.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 nonprod
    { cidr = "10.30.0.0/16", attachment_id = var.tgw_peering_attachment_ue1_ew1_id }, # eu-west-1 prod
  ]
}
