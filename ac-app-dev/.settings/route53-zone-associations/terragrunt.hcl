include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/.settings/route53-private-zones",
    "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/ac-app-dev/eu-west-1/.settings/main-vpc",
  ]
}

dependency "route53_private_zones" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/.settings/route53-private-zones"

  mock_outputs = {
    dev_use1_anycompany_internal_zone_id = ""
    dev_euw1_anycompany_internal_zone_id = ""
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
  environment_name = "development"
  environment_code = "dev"

  dev_use1_anycompany_internal_zone_id = dependency.route53_private_zones.outputs.dev_use1_anycompany_internal_zone_id
  dev_euw1_anycompany_internal_zone_id = dependency.route53_private_zones.outputs.dev_euw1_anycompany_internal_zone_id

  vpcs = {
    "main_vpc_use1" = {
      "vpc_id" = dependency.main_vpc_use1_app_dev.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_euw1" = {
      "vpc_id" = dependency.main_vpc_euw1_app_dev.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }
}
