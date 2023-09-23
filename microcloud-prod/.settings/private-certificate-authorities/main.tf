locals {
  organization_name = "microcloud"
}

module "prod_corp_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "prod.corp.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

module "prod_vpn_private_ca" {
  source = "git::https://github.com/mateusz-uminski/terraform-service-modules//tls-private-ca?ref=tls-private-ca/v0.1.1"

  # required variables
  organization_name = local.organization_name
  domain_name       = "prod.vpn.microcloud.com"

  # optional variables
  save_to_pem_files = true
}

output "prod_corp_private_ca" {
  value = {
    key  = module.prod_corp_private_ca.private_key_pem
    cert = module.prod_corp_private_ca.cert_pem
  }
  sensitive = true
}

output "prod_vpn_private_ca" {
  value = {
    key  = module.prod_vpn_private_ca.private_key_pem
    cert = module.prod_vpn_private_ca.cert_pem
  }
  sensitive = true
}
