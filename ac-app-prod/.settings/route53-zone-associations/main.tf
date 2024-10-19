variable "prod_use1_anycompany_internal_zone_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "prod_euw1_anycompany_internal_zone_id" {
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

resource "aws_route53_zone_association" "prod_use1_anycompany_internal" {
  for_each = var.vpcs

  zone_id    = var.prod_use1_anycompany_internal_zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.region
}

resource "aws_route53_zone_association" "prod_euw1_anycompany_internal" {
  for_each = var.vpcs

  zone_id    = var.prod_euw1_anycompany_internal_zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.region
}
