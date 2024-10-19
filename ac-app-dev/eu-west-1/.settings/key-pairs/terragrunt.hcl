include "root" {
  path = find_in_parent_folders("main.hcl")
}

inputs = {
  environment_name = "development"
  environment_code = "dev"
}
