locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_alias = "ac-mgmt"
  account_id    = local.config_vars.ac_mgmt_account_id
  aws_profile   = "ac-mgmt-cloudadmin"
}
