include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-management/.settings/iam-identity-center",
    "${get_path_to_repo_root()}/microcloud-management/.settings/iam-identity-center-microdata",
    "${get_path_to_repo_root()}/microcloud-management/.settings/iam-identity-center-micropost"
  ]
}

inputs = {}
