variable "acm_certificate_arn" {}

variable "domain_name" {
  description = "name of static web"
  type        = string
}

variable "origin_id" {
  description = "Origin ID"
  type        = string
}

variable "origin_path" {
  description = "Origin ID"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "origin_bucket_id" {
  description = "Origin Bucket Id"
  type = string 
}

variable "OAI_id" {
  description = "OAI Id"
  type = string 
}

variable "resource_policy" {
  type = string
}

variable "origin_bucket_arn" {}

variable "web_aliases" {}