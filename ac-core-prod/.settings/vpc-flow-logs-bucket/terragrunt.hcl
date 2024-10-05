include "root" {
  path = find_in_parent_folders("main.hcl")
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  ac_app_dev_account_id  = local.config_vars.ac_app_dev_account_id
  ac_app_prod_account_id = local.config_vars.ac_app_prod_account_id
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  allowed_account_ids = [
    local.ac_app_dev_account_id,
    local.ac_app_prod_account_id,
  ]
}
