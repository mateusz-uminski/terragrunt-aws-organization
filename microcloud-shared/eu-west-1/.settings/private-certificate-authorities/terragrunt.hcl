include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-shared/.settings/private-certificate-authorities",
  ]
}

dependency "shared_ca" {
  config_path = "${get_path_to_repo_root()}/microcloud-shared/.settings/private-certificate-authorities"

  mock_outputs = {
    shared_corp_private_ca = ""
    shared_vpn_private_ca  = ""
  }
}

inputs = {
  shared_corp_private_ca = dependency.shared_ca.outputs.shared_corp_private_ca
  shared_vpn_private_ca  = dependency.shared_ca.outputs.shared_vpn_private_ca
}
