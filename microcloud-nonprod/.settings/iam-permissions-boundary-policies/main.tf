module "iam_permissions_boundary_policies" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//iam-permissions-boundary-policies?ref=iam-permissions-boundary-policies/v0.1.0"

  org_abbreviated_name = var.org_abbreviated_name
}
