include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/.settings/route53-private-zones",
  ]
}

dependency "route53_private_zone" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/.settings/route53-private-zones"

  mock_outputs = {
    dev_use1_anycompany_internal_zone_id = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  hosted_zone_id = dependency.route53_private_zone.outputs.dev_use1_anycompany_internal_zone_id
}
