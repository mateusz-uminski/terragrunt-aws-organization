include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-nonprod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-tgw-peering",
  ]
}

dependency "main_vpc_shared" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_vpc_nonprod" {
  config_path = "${get_path_to_repo_root()}/microcloud-nonprod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_vpc_prod" {
  config_path = "${get_path_to_repo_root()}/microcloud-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_tgw_peering" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-tgw-peering"

  mock_outputs = {
    ue1_ew1_tgw_attachment_id = ""
  }
}

inputs = {
  vpc_tgw_attachment_id_shared  = dependency.main_vpc_shared.outputs.tgw_attachment_id
  vpc_tgw_attachment_id_nonprod = dependency.main_vpc_nonprod.outputs.tgw_attachment_id
  vpc_tgw_attachment_id_prod    = dependency.main_vpc_prod.outputs.tgw_attachment_id

  tgw_peering_attachment_ue1_ew1_id = dependency.main_tgw_peering.outputs.ue1_ew1_tgw_attachment_id
}
