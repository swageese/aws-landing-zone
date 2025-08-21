variable "region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "project" {
  type        = string
  description = "Project/landing zone name used for tagging"
  default     = "lz-demo"
}

variable "domain_name" {
  type        = string
  description = "Route53 Hosted Zone domain name to create (public). Leave empty to use an existing zone via var.hosted_zone_id."
  default     = "example1.com"
}

variable "hosted_zone_id" {
  type        = string
  description = "If using an existing public hosted zone, provide its ID and leave domain_name blank."
  default     = "Z0923410J02XE9KJIA87"
}

variable "record_name" {
  type        = string
  description = "Record name to create under the hosted zone (e.g., 'www')."
  default     = "www"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH to the instance (set to your IP/32). Use 0.0.0.0/0 for demo only."
  default     = "0.0.0.0/0"
}
