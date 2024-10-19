include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/ac-app-dev/us-east-1/.settings/main-vpc"
  ]
}

inputs = {
  environment_name = "development"
  environment_code = "dev"
}
