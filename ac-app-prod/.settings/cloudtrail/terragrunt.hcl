include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/.settings/cloudtrail"
  ]
}

dependency "cloudtrail_bucket" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/.settings/cloudtrail"

  mock_outputs = {
    bucket_name = ""
  }
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  cloudtrail_s3_bucket_name = dependency.cloudtrail_bucket.outputs.bucket_name
}
