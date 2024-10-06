include "root" {
  path = find_in_parent_folders("main.hcl")
}

inputs = {
  environment_name = "production"
  environment_code = "prod"
}
