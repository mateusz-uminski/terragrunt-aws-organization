include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway"
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway"

  mock_outputs = {
    arn = ""
  }
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  ac_app_dev_account_id = local.config_vars.ac_app_dev_account_id
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  transit_gateway_arn = dependency.transit_gateway.outputs.arn
  principal           = local.ac_app_dev_account_id
}
