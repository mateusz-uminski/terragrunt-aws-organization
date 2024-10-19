variable "transit_gateway_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "transit_gateway_euw1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  tgw_name = "main"
}

resource "aws_ec2_transit_gateway_peering_attachment" "use1_euw1" {
  transit_gateway_id      = var.transit_gateway_id
  peer_account_id         = var.account_id
  peer_region             = "eu-west-1"
  peer_transit_gateway_id = var.transit_gateway_euw1_id

  tags = {
    Name = "${var.org_code}-${local.tgw_name}-tgw-peering-use1-euw1"
  }
}

output "use1_euw1_tgw_attachment_id" {
  value = aws_ec2_transit_gateway_peering_attachment.use1_euw1.id
}
