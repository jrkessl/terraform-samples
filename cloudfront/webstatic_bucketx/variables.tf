variable "domain_name" {
  description = "name of static web"
  type        = string
}

variable "acl" {
  description = "ACL"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Bool to enable destroy bucket with info"
  type        = bool
  default     = true
}
