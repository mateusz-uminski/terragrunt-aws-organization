locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_name   = "shared"
  aws_account_id = local.config_vars.shared_microcloud_aws_account_id
  aws_profile    = "shared-microcloud-cloudadmin"
}
