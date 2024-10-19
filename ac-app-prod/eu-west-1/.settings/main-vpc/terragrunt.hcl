include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/.settings/vpc-flow-logs-bucket",
    "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway",
  ]
}

dependency "vpc_flow_logs_bucket" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/.settings/vpc-flow-logs-bucket"

  mock_outputs = {
    arn = ""
  }
}

dependency "transit_gateway" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/eu-west-1/.settings/main-transit-gateway"

  mock_outputs = {
    id = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  vpc_flow_logs_s3_bucket_arn = dependency.vpc_flow_logs_bucket.outputs.arn
  transit_gateway_id          = dependency.transit_gateway.outputs.id
}
