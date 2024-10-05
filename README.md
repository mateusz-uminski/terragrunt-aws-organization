# terragrunt-aws-organization

[![lint](https://github.com/mateusz-uminski/terragrunt-aws-organization/actions/workflows/lint.yaml/badge.svg)](https://github.com/mateusz-uminski//terragrunt-aws-organization/actions/workflows/lint.yaml)

This terragrunt code provisions my test environment in AWS cloud (see [AnyCompany organization](#organization-anycompany)).
I use this environment to practice AWS concepts, prepare to AWS certificates and verify crazy ideas. Besides README.md,
further documentation can be found in commits, code comments and nested README files.

Feel free to explore and copy everything you want.
Enjoy!


# What is AnyCompany?
AnyCompany (AC) is a fictional Software as a Service (Saas) company to demonstrate sample use cases.

- [Organization design](docs/01-organization-design.md)
- [Network design](docs/02-network-design.md)


# Requirements
1. Terraform version ~> 1.3.3
2. Terragrunt version ~> 0.39.2
3. AWS Accounts


# How to use?
1. Create `config.yaml` file in the project's root directory according to the `example-config.yaml`.
2. Follow steps from [How to prepare an AWS Organization?](#how-to-prepare-an-aws-organization?).
3. Execute `terragrunt run-all ac-mgmt/.settings`


# How to prepare an AWS Organization?
1. Create at least 4 AWS accounts: one for the management account, one for shared/central services such as IAM and Route53,
 one dev account and one prod account.
2. Configure MFA on each account.
3. Create an AWS Organization on management account, set consolidated billing and invite other accounts to the organization.
4. Enable SCP in the organization.
5. On each account create a cloudadmin IAM user, then attach directly existing policy `AdministratorAccess` to it.
6. Configure MFA for each cloudadmin user.
7. Generate AWS_ACCESS_KEY_ID and AWS_ACCESS_SECRET_KEY for each cloudadmin user.
8. Configure the following profiles in `~/.aws/credentials` and `~/.aws/config`:
- `ac-mgmt-cloudadmin`
- `ac-core-prod-cloudadmin`
- `ac-app-dev-cloudadmin`
- `ac-app-prod-cloudadmin`
9. Execute `cd ac-mgmt/.settings/organization && terragrunt apply` and then attach AWS accounts to appropriate
organizational units.


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
| account-dev/
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
