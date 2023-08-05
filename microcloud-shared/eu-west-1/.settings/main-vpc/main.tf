variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

variable "transit_gateway_id" {
  type        = string
  description = "Defined in the terragrunt.hcl file."
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

module "vpc" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//vpc?ref=vpc/v0.4.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  vpc_name             = "main"
  vpc_tier             = "shared"
  vpc_cidr             = "10.18.0.0/16"

  public_subnets  = ["10.18.0.0/20", "10.18.16.0/20", "10.18.32.0/20"]
  private_subnets = ["10.18.64.0/20", "10.18.80.0/20", "10.18.96.0/20"]
  storage_subnets = ["10.18.128.0/20", "10.18.144.0/20", "10.18.160.0/20"]

  # optional variables
  vpc_flow_logs_s3_bucket_arn = var.vpc_flow_logs_s3_bucket_arn
  transit_gateway_id          = var.transit_gateway_id

  private_subnets_ingress_nacl = {
    "10"  = "${chomp(data.http.my_ip.response_body)}/32"
    "200" = "10.24.0.0/16", # main vpc eu-west-1 nonpprod
    "300" = "10.30.0.0/16", # main vpc eu-west-1 prod
  }
}

output "tgw_attachment_id" {
  value = module.vpc.tgw_attachment_id
}
