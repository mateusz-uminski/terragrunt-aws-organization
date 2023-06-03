locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_name   = "mgmt"
  aws_account_id = local.config_vars.mgmt_microcloud_aws_account_id
  aws_profile    = "mgmt-microcloud-cloudadmin"
}
