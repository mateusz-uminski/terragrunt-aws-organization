include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/route53-private-zones",
    "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/vpc-endpoints",
  ]
}

dependency "route53_private_zone" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/route53-private-zones"

  mock_outputs = {
    ue1_shared_corp_microcloud_com_zone_id = ""
  }
}

dependency "vpc_endpoints" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/us-east-1/.settings/vpc-endpoints"

  mock_outputs = {
    s3_vpc_endpoint_dns_name = ""
  }
}

inputs = {
  hosted_zone_id = dependency.route53_private_zone.outputs.ue1_shared_corp_microcloud_com_zone_id

  s3_vpc_endpoint = dependency.vpc_endpoints.outputs.s3_vpc_endpoint_dns_name
}
