locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_name = "mcd-shared"
  account_id   = local.config_vars.mcd_account_id_shared
  aws_profile  = "mcd-cloudadmin-shared"
}
