locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_alias = "ac-app-prod"
  account_id    = local.config_vars.ac_app_prod_account_id
  aws_profile   = "ac-app-prod-cloudadmin"
}
