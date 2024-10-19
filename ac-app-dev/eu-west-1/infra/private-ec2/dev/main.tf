module "ec2" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//ec2?ref=ec2-v0.1.1"


  # required variables
  org_code     = var.org_code
  project_code = var.project_code
  env_code     = var.environment_code

  instance_name    = "private"
  instance_type    = "t2.micro"
  ami_name_pattern = "al2023-ami-2023*"
  key_pair         = "ac-main-key-pair"

  vpc_name    = "ac-main-vpc-dev"
  subnet_name = "ac-main-private-sn1-dev"

  # optional variables
  assign_public_ip           = false
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
