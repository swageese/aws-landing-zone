variable "project"        { type = string }
variable "domain_name"    {
     type = string
    default = ""
     }
variable "hosted_zone_id" {
     type = string
    default = ""
    }
variable "record_name"    { type = string }
variable "target_ip"      { type = string }
