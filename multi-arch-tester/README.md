# multi-arch-tester
## About
This code was made to easily launch 2 EC2 instances in AWS, one x86 and one ARM architecture.
The network settings are adjusted to the 5161 AWS dev account. 
## How to use
1. Ajust the security group ingress rule to match your current IP in the terraform file in this repo.  
2. Run `terraform apply` and the output will generate the connection command to the 2 instances.  

Docker will be already installed. Then just play with your images.  
Do not forget to `terraform destroy` in the end. The terraform state file is kept locally. 