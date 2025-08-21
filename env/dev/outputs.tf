output "vpc_id" { value = module.network.vpc_id }
output "public_subnet_id" { value = module.network.public_subnet_id }
output "ec2_public_ip" { value = module.compute.eip_public_ip }
output "ec2_instance_id" { value = module.compute.instance_id }
#output "route53_zone_id"   { value = module.dns.zone_id }
#output "route53_record_fqdn" { value = module.dns.record_fqdn }
