# IAM Design

There are following IAM Roles that can be used to access an AWS account within the microcloud organization:
- **cloudadmin**: grants access to an account with `AdministratorAccess` privileges.
- **cloudviewer**: grants access to an account with `ReadOnlyAccess` privileges.
- **guest**: allows to grant access to an account to specific individuals with personalized permissions.
- **project-admin** (`micropost-admin`, `microdata-admin`): grants access to an AWS account with `AdministratorAccess` privileges with the imposed permissions boundary policy named `mcd-project-admin-permissions-boundary-policy`.
- **project-developer** (`micropost-developer`, `microdata-developer`): grants access to an AWS account with `ReadOnlyAccess` privileges. The project's developer permissions can be extended to include the ability to edit resources belonging to the project in which the developer is working, if necessary.


The IAM Role assignment matrix:
|                   | microcloud-management | microcloud-shared | microcloud-nonprod    | microcloud-prod   |
| :---              | :---:                 | :---:             | :---:                 | :---:             |
| cloud engineer    | cloudadmin            | cloudadmin        | cloudadmin            | cloudadmin        |
| devops            | cloudviewer           | cloudviewer       | project-admin         | project-developer |
| developer         | -                     | cloudviewer       | project-developer     | cloudviewer       |
| individuals       | guest                 | guest             | guest                 | guest             |

Note: The roles that have names starting with the project's name grant permissions to AWS resources based on either the principal tag (tags with the prefix `ac:`) or the resource's name.


![](./assets/iam-design.drawio.svg)


source:
- [aws docs: abac](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html)
- [aws security blog: abac](https://aws.amazon.com/blogs/security/working-backward-from-iam-policies-and-principal-tags-to-standardized-names-and-tags-for-your-aws-resources/)
