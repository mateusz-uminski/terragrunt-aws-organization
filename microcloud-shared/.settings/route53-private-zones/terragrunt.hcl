include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-prod/eu-west-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-nonprod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-nonprod/eu-west-1/.settings/main-vpc",
  ]
}

dependency "main_vpc_ue1_shared" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_ew1_shared" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_ue1_prod" {
  config_path = "${get_path_to_repo_root()}/microcloud-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_ew1_prod" {
  config_path = "${get_path_to_repo_root()}/microcloud-prod/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_ue1_nonprod" {
  config_path = "${get_path_to_repo_root()}/microcloud-nonprod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_ew1_nonprod" {
  config_path = "${get_path_to_repo_root()}/microcloud-nonprod/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}


inputs = {
  vpcs = {
    "main_vpc_ue1_shared" = {
      "vpc_id" = dependency.main_vpc_ue1_shared.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_ew1_shared" = {
      "vpc_id" = dependency.main_vpc_ew1_shared.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }

  external_vpcs_prod = {
    "main_vpc_ue1_prod" = {
      "vpc_id" = dependency.main_vpc_ue1_prod.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_ew1_prod" = {
      "vpc_id" = dependency.main_vpc_ew1_prod.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }

  external_vpcs_dev = {
    "main_vpc_ue1_nonprod" = {
      "vpc_id" = dependency.main_vpc_ue1_nonprod.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_ew1_nonprod" = {
      "vpc_id" = dependency.main_vpc_ew1_nonprod.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }
}
