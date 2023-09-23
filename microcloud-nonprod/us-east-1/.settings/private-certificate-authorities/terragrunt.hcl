include "root" {
  path = find_in_parent_folders("main.hcl")
}

dependencies {
  paths = [
    "${get_path_to_repo_root()}/microcloud-nonprod/.settings/private-certificate-authorities",
  ]
}

dependency "nonprod_ca" {
  config_path = "${get_path_to_repo_root()}/microcloud-nonprod/.settings/private-certificate-authorities"

  mock_outputs = {
    nonprod_corp_private_ca = ""
    nonprod_vpn_private_ca  = ""
  }
}

inputs = {
  nonprod_corp_private_ca = dependency.nonprod_ca.outputs.nonprod_corp_private_ca
  nonprod_vpn_private_ca  = dependency.nonprod_ca.outputs.nonprod_vpn_private_ca
}
