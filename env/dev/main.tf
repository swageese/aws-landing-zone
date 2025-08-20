module "network" {
  source       = "../../modules/network"
  vpc_cidr     = "10.0.0.0/16"
  public_cidr  = "10.0.1.0/24"
  private_cidr = "10.0.2.0/24"
}

module "iam" {
  source = "../../modules/iam"
}

module "logging" {
  source = "../../modules/logging"
}

module "compute" {
  source         = "../../modules/compute"
  subnet_id      = module.network.public_subnet_id
  vpc_id         = module.network.vpc_id
  instance_type  = "t2.micro"
  key_name       = "hemanth-key"
}
