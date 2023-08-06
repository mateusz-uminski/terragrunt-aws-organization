variable "tgw_peering_attachment_ue1_ew1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  org      = var.org_abbreviated_name
  tgw_name = "main"
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ue1_ew1" {
  transit_gateway_attachment_id = var.tgw_peering_attachment_ue1_ew1_id

  tags = {
    Name = "${local.org}-${local.tgw_name}-tgw-peering-eu1-ew1"
  }
}
