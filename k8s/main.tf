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

# aws eks update-kubeconfig --region sa-east-1 --name TestK8sCluster && export PS1="TestK8sCluster \e[0;32m[\u@Ubuntu \W]\$ \e[0m" && alias k='kubectl'
