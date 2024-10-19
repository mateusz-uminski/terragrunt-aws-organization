include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-peering",
  ]
}

dependency "main_vpc_ac_core_prod" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_vpc_ac_app_dev" {
  config_path = "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_vpc_ac_app_prod" {
  config_path = "${get_path_to_repo_root()}/ac-app-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    tgw_attachment_id = ""
  }
}

dependency "main_tgw_peering" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-tgw-peering"

  mock_outputs = {
    use1_euw1_tgw_attachment_id = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  vpc_tgw_attachment_id_ac_core_prod = dependency.main_vpc_ac_core_prod.outputs.tgw_attachment_id
  vpc_tgw_attachment_id_ac_app_dev   = dependency.main_vpc_ac_app_dev.outputs.tgw_attachment_id
  vpc_tgw_attachment_id_ac_app_prod  = dependency.main_vpc_ac_app_prod.outputs.tgw_attachment_id

  tgw_peering_attachment_use1_euw1_id = dependency.main_tgw_peering.outputs.use1_euw1_tgw_attachment_id
}
