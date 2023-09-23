locals {
  organization_name = "microcloud"
}

module "shared_corp_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "shared.corp.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

module "shared_vpn_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "shared.vpn.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

output "shared_corp_private_ca" {
  value = {
    key  = module.shared_corp_private_ca.private_key_pem
    cert = module.shared_corp_private_ca.cert_pem
  }
  sensitive = true
}

output "shared_vpn_private_ca" {
  value = {
    key  = module.shared_vpn_private_ca.private_key_pem
    cert = module.shared_vpn_private_ca.cert_pem
  }
  sensitive = true
}
