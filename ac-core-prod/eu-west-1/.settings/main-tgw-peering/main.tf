variable "tgw_peering_attachment_use1_euw1_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

locals {
  tgw_name = "main"
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "use1_euw1" {
  transit_gateway_attachment_id = var.tgw_peering_attachment_use1_euw1_id

  tags = {
    Name = "${var.org_code}-${local.tgw_name}-tgw-peering-use1-euw1"
  }
}
