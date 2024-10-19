include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-prod/eu-west-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-dev/eu-west-1/.settings/main-vpc",
  ]
}

dependency "main_vpc_use1_core_prod" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_euw1_core_prod" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_use1_app_prod" {
  config_path = "${get_path_to_repo_root()}/ac-app-prod/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_euw1_app_prod" {
  config_path = "${get_path_to_repo_root()}/ac-app-prod/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_use1_app_dev" {
  config_path = "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}

dependency "main_vpc_euw1_app_dev" {
  config_path = "${get_path_to_repo_root()}/ac-app-dev/eu-west-1/.settings/main-vpc"

  mock_outputs = {
    vpc_id = ""
  }
}


inputs = {
  environment_name = "production"
  environment_code = "prod"

  vpcs = {
    "main_vpc_use1_core_prod" = {
      "vpc_id" = dependency.main_vpc_use1_core_prod.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_euw1_core_prod" = {
      "vpc_id" = dependency.main_vpc_euw1_core_prod.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }

  external_vpcs_prod = {
    "main_vpc_use1_app_prod" = {
      "vpc_id" = dependency.main_vpc_use1_app_prod.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_euw1_app_prod" = {
      "vpc_id" = dependency.main_vpc_euw1_app_prod.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }

  external_vpcs_dev = {
    "main_vpc_use1_app_dev" = {
      "vpc_id" = dependency.main_vpc_use1_app_dev.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_euw1_app_dev" = {
      "vpc_id" = dependency.main_vpc_euw1_app_dev.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }
}
