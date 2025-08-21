variable "project"              { type = string }
variable "subnet_id"            { type = string }
variable "vpc_id"               { type = string }
variable "iam_instance_profile" { type = string }
variable "instance_type" { 
    type = string
 default = "t3.micro" 
 }
variable "allowed_ssh_cidr"     { 
    type = string
 default = "0.0.0.0/0" 
 }
