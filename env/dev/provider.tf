provider "aws" {
  region = var.region
}

# Uncomment to assume a role for landing zone provisioning
# provider "aws" {
#   alias  = "org"
#   region = var.region
#   assume_role {
#     role_arn = var.provisioner_role_arn
#   }
# }
