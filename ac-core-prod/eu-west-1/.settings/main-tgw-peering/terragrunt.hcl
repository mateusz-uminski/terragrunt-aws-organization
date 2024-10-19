include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-peering",
  ]
}

dependency "tgw_peering_use1" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-peering"

  mock_outputs = {
    use1_euw1_tgw_attachment_id = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  tgw_peering_attachment_use1_euw1_id = dependency.tgw_peering_use1.outputs.use1_euw1_tgw_attachment_id
}
