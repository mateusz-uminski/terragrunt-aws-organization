module "ec2" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//ec2?ref=ec2/v0.3.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  project              = "infra"
  environment          = "prod"

  instance_name    = "public"
  instance_type    = "t2.micro"
  ami_name_pattern = "CentOS-Stream-ec2-9-*"
  key_pair         = "mcd-main-key-pair"

  vpc_name    = "mcd-main-vpc-shared"
  subnet_name = "mcd-main-public-sn1-shared"

  # optional variables
  assign_public_ip           = true
  instance_profile_name      = ""
  enable_detailed_monitoring = false

  root_ebs_size  = 0
  additional_ebs = {}

  user_data = <<-EOF
    #! /bin/bash
    touch /helloworld.txt
  EOF

  additional_security_groups = []
  allowed_ingress_cidrs      = []
  allowed_ingress_sgs        = []
}
