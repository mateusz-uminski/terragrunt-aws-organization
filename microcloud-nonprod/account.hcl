locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  account_name   = "mcd-nonprod"
  aws_account_id = local.config_vars.mcd_aws_account_id_nonprod
  aws_profile    = "mcd-cloudadmin-nonprod"
}
