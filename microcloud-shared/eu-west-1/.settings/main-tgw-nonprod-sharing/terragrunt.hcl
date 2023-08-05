include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-transit-gateway"
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-transit-gateway"

  mock_outputs = {
    arn = ""
  }
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  mcd_account_id_nonprod = local.config_vars.mcd_account_id_nonprod
}

inputs = {
  transit_gateway_arn = dependency.transit_gateway.outputs.arn
  principal           = local.mcd_account_id_nonprod
}
