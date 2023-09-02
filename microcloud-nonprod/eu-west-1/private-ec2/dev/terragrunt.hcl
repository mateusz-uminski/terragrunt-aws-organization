include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-nonprod/eu-west-1/.settings/main-vpc"
  ]
}

inputs = {}
