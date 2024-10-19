locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_alias = "ac-app-dev"
  account_id    = local.config_vars.ac_app_dev_account_id
  aws_profile   = "ac-app-dev-cloudadmin"
}
