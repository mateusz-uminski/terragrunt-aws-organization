include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-prod/.settings/private-certificate-authorities",
  ]
}

dependency "prod_ca" {
  config_path = "${get_path_to_repo_root()}/microcloud-prod/.settings/private-certificate-authorities"

  mock_outputs = {
    prod_corp_private_ca = ""
    prod_vpn_private_ca  = ""
  }
}

inputs = {
  prod_corp_private_ca = dependency.prod_ca.outputs.prod_corp_private_ca
  prod_vpn_private_ca  = dependency.prod_ca.outputs.prod_vpn_private_ca
}
