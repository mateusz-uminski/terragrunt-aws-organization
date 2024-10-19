resource "aws_key_pair" "main" {
  key_name   = "${var.org_code}-main-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}
