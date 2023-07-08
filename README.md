# terragrunt-aws-infrastructures
This terragrunt code provisions my test environment in AWS cloud (see [microcloud organization](#organization-microcloud)).
I use this environment to practice AWS concepts, prepare to AWS certificates and verify crazy ideas. Besides README.md,
further documentation can be found in commits, code comments and nested README files.
<br><br>
Feel free to explore and copy everything you want.
Enjoy!
<br><br>
Terragrunt uses terraform modules from this repository: [terraform-aws-modules](https://github.com/mateusz-uminski/terraform-aws-modules)

# Requirements
1. Terraform version ~> 1.3.3
2. Terragrunt version ~> 0.39.2
3. AWS Accounts

# How to use?
0. Create config.yaml in the project's root directory according to the example-config.yaml.
1. Do steps from [Organization design](#how-to-prepare-an-aws-organization?).
2. Configure the following profiles in `~/.aws/credentials` and `~/.aws/config`:
- `mcd-cloudadmin-mgmt`
- `mcd-cloudadmin-shared`
- `mcd-cloudadmin-nonprod`
- `mcd-cloudadmin-prod`
3. Execute `terragrunt run-all microcloud-management/.settings`

# How to prepare an AWS Organization?
1. Create at least 4 AWS accounts: one for the management account, one for shared/central services such as Route53,
 one nonprod account and one prod account.
2. Configure MFA on each account.
3. Create an AWS Organization on management account, set consolidated billing and invite other accounts to the organization.
4. Enable SCP in the organization.
5. On each account create cloudadmin IAM user, then attach directly existing policy `AdministratorAccess` to it.
6. Configure MFA for each cloudadmin user.
7. Generate AWS_ACCESS_KEY_ID and AWS_ACCESS_SECRET_KEY for each cloudadmin user.
8. Execute `cd microcloud-management/.settings/organization && terragrunt apply` and then attach AWS accounts to appropriate
organizational units.
9. Enable IAM Identity Center.
10. Change MFA settings to: `Every time they sign in (always-on)` and `Require them to register an MFA device at sign in`.
11. Enable `Attributes for access control`.
12. Add the following attribute: `ac:project = ${path:enterprise.division}`.

# Project structure
Note: modules that configure either account or region should be placed in the `.settings` directory.
The code in this repo uses the following project structure:
```
|
| account-name/
| | region-name/
| | | stack-name/
| | | | environment/
| | | | | - terragrunt.hcl
| | | | | - main.tf
...
```

For instance:
```
| account-nonprod/
| | us-east-1/
| | | .settings/
| | | | vpc/
| | | | | - main.tf
| | | | | - terragrunt.hcl
| | | stackA/
| | | | dev/
| | | | | - terragrunt.hcl
| | | | | - main.tf
| | | - region.hcl
| |
| | .settings/
| | | stackB/
| | | | - terragrunt.hcl
| | | | - main.tf
| |
| | eu-west-1/
| | | .settings/
| | | | vpc/
| | | | | - main.tf
| | | | | - terragrunt.hcl
| | | stackC/
| | | | dev/
| | | | | - terragrunt.hcl
| | | | | - main.tf
| | | - region.hcl
| |
| | - account.hcl
```

# Organization: microcloud
- [Organization design](docs/01-organization-design.md)
- [IAM design](docs/02-iam-design.md)
- [Resource naming convention](docs/03-resource-naming-convention.md)
- [Resource tagging convention](docs/04-resource-tagging-convention.md)
- [Network design](docs/05-network-design.md)
- [VPC Peering](docs/06-vpc-peering.md)
- [Route53](docs/07-route53.md)
- [VPN](docs/08-vpn.md)
- [Cloudfront](docs/09-cloudfront.md)
- [EKS](docs/10-eks.md)
