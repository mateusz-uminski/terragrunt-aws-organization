include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-core-prod/.settings/cloudtrail-bucket",
  ]
}

dependency "cloudtrail_bucket" {
  config_path = "${get_path_to_repo_root()}/ac-core-prod/.settings/cloudtrail-bucket"

  mock_outputs = {
    bucket_name = ""
  }
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  ac_app_dev_account_id  = local.config_vars.ac_app_dev_account_id
  ac_app_prod_account_id = local.config_vars.ac_app_prod_account_id
}

inputs = {
  environment_name = "production"
  environment_code = "prod"

  bucket_name = dependency.cloudtrail_bucket.outputs.bucket_name

  allowed_account_ids = [
    local.ac_app_dev_account_id,
    local.ac_app_prod_account_id,
  ]
}
