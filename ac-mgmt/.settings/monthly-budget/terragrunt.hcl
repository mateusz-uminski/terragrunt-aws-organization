include "root" {
  path = find_in_parent_folders("main.hcl")
}

locals {
  config_vars = yamldecode(file(find_in_parent_folders("config.yaml")))

  email_address = local.config_vars.monthly_budget_email_address
}

inputs = {
  environment_name = "production"
  environment_code = "prod"
  email_address    = local.email_address
}
