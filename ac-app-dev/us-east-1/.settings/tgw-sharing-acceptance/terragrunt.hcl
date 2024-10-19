include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-sharing-app-dev"
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-sharing-app-dev"

  mock_outputs = {
    arn = ""
  }
}

inputs = {
  environment_name = "development"
  environment_code = "dev"

  share_arn = dependency.transit_gateway.outputs.arn
}
