locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_name   = "dev"
  aws_account_id = local.config_vars.dev_microcloud_aws_account_id
  aws_profile    = "dev-microcloud-cloudadmin"
}
