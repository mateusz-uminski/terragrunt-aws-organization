locals {
  organization_name = "microcloud"
}

module "nonprod_corp_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "nonprod.corp.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

module "nonprod_vpn_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "nonprod.vpn.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

output "nonprod_corp_private_ca" {
  value = {
    key  = module.nonprod_corp_private_ca.private_key_pem
    cert = module.nonprod_corp_private_ca.cert_pem
  }
  sensitive = true
}

output "nonprod_vpn_private_ca" {
  value = {
    key  = module.nonprod_vpn_private_ca.private_key_pem
    cert = module.nonprod_vpn_private_ca.cert_pem
  }
  sensitive = true
}
