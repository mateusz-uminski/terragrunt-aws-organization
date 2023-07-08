include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/cloudtrail"
  ]
}

dependency "cloudtrail_bucket" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/cloudtrail"

  mock_outputs = {
    bucket_name = ""
  }
}

inputs = {
  cloudtrail_s3_bucket_name = dependency.cloudtrail_bucket.outputs.bucket_name
}
