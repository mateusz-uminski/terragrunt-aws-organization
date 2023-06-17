include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-nonprod/.settings/iam-permissions-boundary-policies",
    "${get_path_to_repo_root()}/microcloud-prod/.settings/iam-permissions-boundary-policies"
  ]
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  mcd_account_id_nonprod = local.config_vars.mcd_account_id_nonprod
  mcd_account_id_prod    = local.config_vars.mcd_account_id_prod
}

inputs = {
  aws_accounts = [
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
