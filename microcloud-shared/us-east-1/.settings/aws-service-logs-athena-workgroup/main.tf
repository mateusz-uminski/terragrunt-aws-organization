module "athena_workgroup" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//athena-workgroup?ref=athena-workgroup/v0.1.0"

  # required variables
  org_abbreviated_name = var.org_abbreviated_name
  workgroup_name       = "aws-service-logs"
  bucket_owner         = var.account_id
}
