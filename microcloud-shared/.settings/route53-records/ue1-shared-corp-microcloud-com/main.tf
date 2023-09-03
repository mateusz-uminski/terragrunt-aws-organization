variable "hosted_zone_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "s3_vpc_endpoint_dns_name" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  hosted_zone_name = "ue1.shared.corp.microcloud.com"
}

resource "aws_route53_record" "example" {
  zone_id = var.hosted_zone_id

  name    = "example.${local.hosted_zone_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["example"]
}

resource "aws_route53_record" "s3_vpc_endpoint" {
  zone_id = var.hosted_zone_id

  name    = "s3.${local.hosted_zone_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.s3_vpc_endpoint_dns_name]
}
