# -------------------------
# Networking (VPC + public subnet)
# -------------------------
module "network" {
  source      = "../../modules/network"
  project     = var.project
  vpc_cidr    = "10.20.0.0/16"
  public_cidr = "10.20.1.0/24"
}

# -------------------------
# IAM baseline for EC2 (role + instance profile)
# -------------------------
module "iam" {
  source  = "../../modules/iam"
  project = var.project
}

# -------------------------
# Logging baseline (S3 + CloudTrail)
# -------------------------
module "logging" {
  source      = "../../modules/logging"
  project     = var.project
  region      = "us-east-1"
  bucket_name = "hemanth-landingzones-1"
}

# -------------------------
# Compute (web EC2 in public subnet + EIP)
# -------------------------
module "compute" {
  source               = "../../modules/compute"
  project              = var.project
  subnet_id            = module.network.public_subnet_id
  vpc_id               = module.network.vpc_id
  iam_instance_profile = module.iam.instance_profile_name
  allowed_ssh_cidr     = var.allowed_ssh_cidr
}

# -------------------------
# Route53 (hosted zone + A record to EC2 EIP)
# If domain_name is provided, create a new public hosted zone.
# Otherwise, use existing zone via hosted_zone_id.
# -------------------------
module "dns" {

  source         = "../../modules/dns"
  project        = var.project
  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  record_name    = var.record_name
  target_ip      = module.compute.eip_public_ip
}
