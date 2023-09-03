include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/route53-private-zones",
    "${get_path_to_repo_root()}/microcloud-prod/us-east-1/.settings/main-vpc",
    "${get_path_to_repo_root()}/microcloud-prod/eu-west-1/.settings/main-vpc",
  ]
}

dependency "route53_private_zones" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/route53-private-zones"

  mock_outputs = {
    ue1_shared_corp_microcloud_com_zone_id = ""
    ew1_shared_corp_microcloud_com_zone_id = ""
    ue1_prod_corp_microcloud_com_zone_id   = ""
    ew1_prod_corp_microcloud_com_zone_id   = ""
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

inputs = {
  ue1_shared_corp_microcloud_com_zone_id = dependency.route53_private_zones.outputs.ue1_shared_corp_microcloud_com_zone_id
  ew1_shared_corp_microcloud_com_zone_id = dependency.route53_private_zones.outputs.ew1_shared_corp_microcloud_com_zone_id
  ue1_prod_corp_microcloud_com_zone_id   = dependency.route53_private_zones.outputs.ue1_prod_corp_microcloud_com_zone_id
  ew1_prod_corp_microcloud_com_zone_id   = dependency.route53_private_zones.outputs.ew1_prod_corp_microcloud_com_zone_id

  vpcs = {
    "main_vpc_ue1" = {
      "vpc_id" = dependency.main_vpc_ue1_prod.outputs.vpc_id
      "region" = "us-east-1"
    },
    "main_vpc_ew1" = {
      "vpc_id" = dependency.main_vpc_ew1_prod.outputs.vpc_id
      "region" = "eu-west-1"
    },
  }
}
