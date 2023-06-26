# there's nothing in california.
provider "aws" {
  region = "us-west-1"
}

variable "ticket" {
  type    = string
  default = "ple-1465"
}

variable "project_name" {
  type    = string
  default = "error-page-test"
}

# variable "my_ip" {
#   description = "My current IP"
#   type        = string
#   default     = "189.18.90.14/32"  
# }