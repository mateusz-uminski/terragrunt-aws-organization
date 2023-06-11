include "root" {
  path = find_in_parent_folders("main.hcl")
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  mcd_account_id_mgmt    = local.config_vars.mcd_account_id_mgmt
  mcd_account_id_shared  = local.config_vars.mcd_account_id_shared
  mcd_account_id_nonprod = local.config_vars.mcd_account_id_nonprod
  mcd_account_id_prod    = local.config_vars.mcd_account_id_prod
}

inputs = {
  aws_accounts = [
    {
      "account_name" = "mcd-mgmt"
      "account_tier" = "mgmt"
      "account_id"   = local.mcd_account_id_mgmt,
    },
    {
      "account_name" = "mcd-shared"
      "account_tier" = "shared"
      "account_id"   = local.mcd_account_id_shared,
    },
    {
      "account_name" = "mcd-nonprod"
      "account_tier" = "nonprod"
      "account_id"   = local.mcd_account_id_nonprod,
    },
    {
      "account_name" = "mcd-prod"
      "account_tier" = "prod"
      "account_id"   = local.mcd_account_id_prod,
    }
  ]
}
