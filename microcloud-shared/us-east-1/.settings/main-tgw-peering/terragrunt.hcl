include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-transit-gateway",
    "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-transit-gateway",
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-transit-gateway"

  mock_outputs = {
    id = ""
  }
}

dependency "transit_gateway_ew1" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-transit-gateway"

  mock_outputs = {
    id = ""
  }
}

inputs = {
  transit_gateway_id     = dependency.transit_gateway.outputs.id
  transit_gateway_ew1_id = dependency.transit_gateway_ew1.outputs.id
}
