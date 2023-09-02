module "ec2" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//ec2?ref=ec2/v0.1.1"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  project              = "infra"
  environment          = "prod"

  instance_name    = "private"
  instance_type    = "t2.micro"
  ami_name_pattern = "CentOS-Stream-ec2-9-*"
  key_pair         = "mcd-main-key-pair"

  vpc_name    = "mcd-main-vpc-shared"
  subnet_name = "mcd-main-private-sn1-shared"

  # optional variables
  assign_public_ip = false

  additional_security_groups = []
  allowed_ingress_cidrs      = []
  allowed_ingress_sgs        = []
}
