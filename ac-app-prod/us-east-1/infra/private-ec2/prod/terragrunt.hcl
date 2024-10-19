include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-app-prod/us-east-1/.settings/main-vpc"
  ]
}

inputs = {
  environment_name = "production"
  environment_code = "prod"
}
