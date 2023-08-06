variable "transit_gateway_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "transit_gateway_ew1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  org      = var.org_abbreviated_name
  tgw_name = "main"
}

resource "aws_ec2_transit_gateway_peering_attachment" "ue1_ew1" {
  transit_gateway_id      = var.transit_gateway_id
  peer_account_id         = var.account_id
  peer_region             = "eu-west-1"
  peer_transit_gateway_id = var.transit_gateway_ew1_id

  tags = {
    Name = "${local.org}-${local.tgw_name}-tgw-peering-eu1-ew1"
  }
}

output "ue1_ew1_tgw_attachment_id" {
  value = aws_ec2_transit_gateway_peering_attachment.ue1_ew1.id
}
