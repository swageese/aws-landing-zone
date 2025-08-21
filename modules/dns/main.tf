
locals {
  use_existing = length(var.hosted_zone_id) > 0
}

resource "aws_route53_zone" "this" {
  count = local.use_existing ? 0 : 1
  name  = var.domain_name
  tags  = { Project = var.project }
  comment = "Public hosted zone created by ${var.project}"
}

# A record pointing to the EC2 Elastic IP
resource "aws_route53_record" "a_record" {
  zone_id = var.hosted_zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 60
  records = [var.target_ip]
}

#output "zone_id" {
#value = local.use_existing ? var.hosted_zone_id : aws_route53_zone.this[0].zone_id
#}

#output "record_fqdn" {
#value = "${var.record_name}.${local.use_existing ? data.aws_route53_zone.existing[0].name : var.domain_name}"
#description = "Fully-qualified domain name for the A record"
#}


