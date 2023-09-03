variable "vpcs" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

variable "external_vpcs_prod" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}

variable "external_vpcs_dev" {
  type = map(object({
    vpc_id = string
    region = string
  }))
  description = "Defined in the terragrunt.hcl file."
}
