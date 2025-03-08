variable "aws_region" {
  type        = string
  default     = ""
  description = "AWS region"
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
}


variable "cidr_blocks" {
  description = "A map of CIDR blocks to be chosen when creating VPCs and Subnets."
  type        = map(string)
  default = {
    blockA  = "10.0.0.0/16"   // good for one VPC
    blockA1 = "10.0.0.128/25" // good for one subnet. Contains 128 IPs.
    blockA2 = "10.0.1.0/25"   // good for one subnet. Contains 128 IPs.
    blockA3 = "10.0.1.128/25" // good for one subnet. Contains 128 IPs.
    blockA4 = "10.0.2.0/25"   // good for one subnet. Contains 128 IPs.
  }
}

variable "project_name" {
  type    = string
  default = "TestK8sCluster"
}

variable "max_size" {
  description = "Maximum number of worker instances (cluster nodes) in the cluster's node group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker instances (cluster nodes) in the cluster's node group."  
  type        = number
}

variable "desired_size" {
  description = "How many nodes should the cluster have when it is created. Must be a number between min_size and max_size."
  type        = number
}

variable "instance_type" {
  description = "The instance type for the worker instances of this cluster. The bigger the instance type, the more CPU and RAM they have, and the more they cost."
  type        = string
}

variable "my_ip" {
  description = "Your IP so that SecurityGroup (firewall) rules can be added so that you can access ports 80 or 8080 of any applications you deploy in the cluster. Must be in CIDR block notation, meaning, followed by '/32'."
  type        = string
}
