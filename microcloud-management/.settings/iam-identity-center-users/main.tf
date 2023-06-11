
module "iam_identity_center_users" {
  source = "git::https://github.com/mateusz-uminski/terraform-aws-modules//iam-identity-center-users?ref=iam-identity-center-users/v0.1.1"

  users = {
    "superuser" = {
      display_name = "superuser"
      given_name   = "superuser"
      family_name  = "superuser"
      project      = "architecture"
      email        = "superuser@domain.com"
      groups = [
        "cloudadmins", "cloudviewers", "guests",
        "microdata-admins", "microdata-developers",
        "micropost-admins", "micropost-developers"
      ]
    },
    "microdata-user" = {
      display_name = "microdata-user"
      given_name   = "microdata-user"
      family_name  = "microdata-user"
      project      = "microdata"
      email        = "microdatauser@domain.com"
      groups = [
        "microdata-admins", "microdata-developers",
      ]
    },
    "micropost-user" = {
      display_name = "micropost-user"
      given_name   = "micropost-user"
      family_name  = "micropost-user"
      project      = "micropost"
      email        = "micropostuser@domain.com"
      groups = [
        "micropost-admins", "micropost-developers",
      ]
    },
    "guestuser" = {
      display_name = "guestuser"
      given_name   = "guestuser"
      family_name  = "guestuser"
      project      = ""
      email        = "guestuser@domain.com"
      groups = [
        "guests",
      ]
    }
  }
}
