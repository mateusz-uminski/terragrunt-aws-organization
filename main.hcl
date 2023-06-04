locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_profile  = local.account_vars.locals.aws_profile

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl", "i_dont_exist.hcl"), {
    locals = {
      region = "us-east-1"
    }
  })
  region = local.region_vars.locals.region
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
)

terraform {
  extra_arguments "use_aws_profile" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint",
    ]

    env_vars = {
      AWS_PROFILE = local.aws_profile
    }
  }
}

generate "provider" {
  path      = "provider-gen.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      profile = "${local.aws_profile}"
      region = "${local.region}"
      allowed_account_ids = ["${local.account_id}"]
    }
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.account_name}-terragrunt-terraform-states"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    profile        = local.aws_profile == "mcd-cloudadmin-mgmt" ? "mcd-cloudadmin-mgmt" : "mcd-cloudadmin-shared"
    region         = "us-east-1"
    dynamodb_table = "${local.account_name}-terraform-locks"
  }
  generate = {
    path      = "backend-gen.tf"
    if_exists = "overwrite_terragrunt"
  }
}
