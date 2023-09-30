provider "aws" {
  region = "sa-east-1"
}

variable "project_name" {
  type    = string
  default = "TestK8sCluster"
}

variable "my_ip" {
  description = "My current IP"
  type        = string
  default     = "189.18.90.14/32"  
}


