include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/vpc-flow-logs-bucket"
  ]
}

dependency "vpc_flow_logs_bucket" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/vpc-flow-logs-bucket"

  mock_outputs = {
    arn = ""
  }
}

inputs = {
  vpc_flow_logs_s3_bucket_arn = dependency.vpc_flow_logs_bucket.outputs.arn
}
