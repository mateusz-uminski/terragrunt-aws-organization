include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-transit-gateway",
    "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway",
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-transit-gateway"

  mock_outputs = {
    id = "asd"
  }
}

dependency "transit_gateway_euw1" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway"

  mock_outputs = {
    id = "asd"
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  transit_gateway_id      = dependency.transit_gateway.outputs.id
  transit_gateway_euw1_id = dependency.transit_gateway_euw1.outputs.id
}
