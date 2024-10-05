locals {
  repository_name = "github.com/mateusz-uminski/terragrunt-aws-organization"

  org_name = "anycompany"
  org_code = "ac"

  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  account_alias = local.account_vars.locals.account_alias
  account_id    = local.account_vars.locals.account_id
  aws_profile   = local.account_vars.locals.aws_profile

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl", "i_dont_exist.hcl"), {
    locals = {
      region_name = "us-east-1"
      region_code = "use1"
    }
  })
  region_name = local.region_vars.locals.region_name
  region_code = local.region_vars.locals.region_code

  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl", "i_dont_exist.hcl"), {
    locals = {
      project_name   = "infrastructure"
      project_code   = "infra"
      cost_center_id = "0001"
    }
  })
  project_name   = local.project_vars.locals.project_name
  project_code   = local.project_vars.locals.project_code
  cost_center_id = local.project_vars.locals.cost_center_id

  path = get_path_from_repo_root()
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.project_vars.locals,
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
  path      = "gen-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "aws" {
      profile             = "${local.aws_profile}"
      region              = "${local.region_name}"
      allowed_account_ids = ["${local.account_id}"]

      default_tags {
        tags = {
          "org-name"                           = "${local.org_name}"
          "org-code"                           = "${local.org_code}"
          "${local.org_code}:project-name"     = var.project_name
          "${local.org_code}:project-code"     = var.project_code
          "${local.org_code}:cost-center-id"   = var.cost_center_id
          "${local.org_code}:environment-name" = var.environment_name
          "${local.org_code}:environment-code" = var.environment_code
          "${local.org_code}:repository"       = "${local.repository_name}"
          "${local.org_code}:path"             = "${local.path}"
          "${local.org_code}:tool"             = "terragrunt"
        }
      }

      ignore_tags {
        key_prefixes = ["kubernetes.io/"]
      }
    }
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.org_name}-infrastructure-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    profile        = "ac-core-prod-cloudadmin"
    region         = "us-east-1"
    dynamodb_table = "${local.org_name}-infrastructure-state"
  }
  generate = {
    path      = "gen-backed.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "variables" {
  path      = "gen-variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    variable "org_name" {
      type    = string
      default = "${local.org_name}"
    }

    variable "org_code" {
      type    = string
      default = "${local.org_code}"
    }

    variable "account_alias" {
      type    = string
      default = "${local.account_alias}"
    }

    variable "account_id" {
      type    = string
      default = "${local.account_id}"
    }

    variable "region_name" {
      type    = string
      default = "${local.region_name}"
    }

    variable "region_code" {
      type    = string
      default = "${local.region_code}"
    }

    variable "project_name" {
      type    = string
      default = "${local.project_name}"
    }

    variable "project_code" {
      type    = string
      default = "${local.project_code}"
    }

    variable "cost_center_id" {
      type    = string
      default = "${local.cost_center_id}"
    }

    variable "environment_name" {
      type    = string # should be set in terragrunt.hcl
    }

    variable "environment_code" {
      type    = string # should be set in terragrunt.hcl
    }
  EOF
}
