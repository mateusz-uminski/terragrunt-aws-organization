variable "share_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

resource "aws_ram_resource_share_accepter" "tgw" {
  share_arn = var.share_arn
}
