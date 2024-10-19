include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-sharing-app-prod"
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-sharing-app-prod"

  mock_outputs = {
    arn = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  share_arn = dependency.transit_gateway.outputs.arn
}
