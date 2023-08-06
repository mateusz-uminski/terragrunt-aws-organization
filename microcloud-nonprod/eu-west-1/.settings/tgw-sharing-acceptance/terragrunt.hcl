include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-tgw-nonprod-sharing"
  ]
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-tgw-nonprod-sharing"

  mock_outputs = {
    arn = ""
  }
}

inputs = {
  share_arn = dependency.transit_gateway.outputs.arn
}
