locals {
  org = var.org_abbreviated_name
}

resource "aws_key_pair" "main" {
  key_name   = "${local.org}-main-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}
