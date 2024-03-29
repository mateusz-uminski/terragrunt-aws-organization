variable "ue1_prod_corp_microcloud_com_zone_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "ew1_prod_corp_microcloud_com_zone_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "vpcs" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

resource "aws_route53_zone_association" "ue1_prod_corp_microcloud_com_zone_id" {
  for_each = var.vpcs

  zone_id    = var.ue1_prod_corp_microcloud_com_zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.region
}

resource "aws_route53_zone_association" "ew1_prod_corp_microcloud_com_zone_id" {
  for_each = var.vpcs

  zone_id    = var.ew1_prod_corp_microcloud_com_zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.region
}
