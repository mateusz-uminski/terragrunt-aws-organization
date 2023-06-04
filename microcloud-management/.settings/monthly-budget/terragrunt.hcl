include "root" {
  path = find_in_parent_folders("main.hcl")
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  email_address = local.config_vars.budget_email_address
}

inputs = {
  email_address = local.email_address
}
