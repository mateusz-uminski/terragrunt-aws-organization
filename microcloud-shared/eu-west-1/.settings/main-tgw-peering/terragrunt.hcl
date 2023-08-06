include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-tgw-peering",
  ]
}

dependency "tgw_peering_ue1" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-tgw-peering"

  mock_outputs = {
    ue1_ew1_tgw_attachment_id = ""
  }
}

inputs = {
  tgw_peering_attachment_ue1_ew1_id = dependency.tgw_peering_ue1.outputs.ue1_ew1_tgw_attachment_id
}
