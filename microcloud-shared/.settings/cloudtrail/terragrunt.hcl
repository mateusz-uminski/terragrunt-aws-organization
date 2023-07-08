include "root" {
  path = find_in_parent_folders("main.hcl")
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  mcd_account_id_nonprod = local.config_vars.mcd_account_id_nonprod
  mcd_account_id_prod    = local.config_vars.mcd_account_id_prod
}

inputs = {
  allowed_account_ids = [
    local.mcd_account_id_nonprod,
    local.mcd_account_id_prod,
  ]
}
