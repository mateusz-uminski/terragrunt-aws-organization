include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/cloudtrail",
    "${get_path_to_repo_root()}/microcloud-shared/.settings/vpc-flow-logs-bucket",
  ]
}

dependency "cloudtrail_bucket" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/cloudtrail"

  mock_outputs = {
    bucket_name = ""
  }
}

dependency "vpc_flow_logs_bucket" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/vpc-flow-logs-bucket"

  mock_outputs = {
    name = ""
  }
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  mcd_account_id_shared  = local.config_vars.mcd_account_id_shared
  mcd_account_id_nonprod = local.config_vars.mcd_account_id_nonprod
  mcd_account_id_prod    = local.config_vars.mcd_account_id_prod
}

inputs = {
  account_ids = [
    local.mcd_account_id_shared,
    local.mcd_account_id_nonprod,
    local.mcd_account_id_prod,
  ]

  cloudtrail_bucket    = dependency.cloudtrail_bucket.outputs.bucket_name
  vpc_flow_logs_bucket = dependency.vpc_flow_logs_bucket.outputs.name
}
