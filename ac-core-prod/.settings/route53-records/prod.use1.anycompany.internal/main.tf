variable "hosted_zone_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  hosted_zone_name = "prod.use1.anycompany.internal"
}

resource "aws_route53_record" "example" {
  zone_id = var.hosted_zone_id

  name    = "example.${local.hosted_zone_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["example"]
}
