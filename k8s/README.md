# Terraform sample - Kubernetes cluster in AWS EKS service
This is all set to launch a Kubernetes cluster in AWS EKS service. From the VPC, subnets, route tables, all the way to the cluster itself and 1 cluster node, all gets created by this code.  

Usage: just have your AWS CLI credentials setup in your shell session and do a ```terraform apply```. After terraforming finishes, do this to configure kubectl and you are ready to start using kubectl: 
```
aws eks update-kubeconfig --region sa-east-1 --name TestK8sCluster
```
Note1: the region in which this stuff gets created is in file ```main.tf```. If you update the region there, update it here too (this code wasn't written to rely in shell variable AWS_DEFAULT_REGION).   
Note2: the name of the cluster that gets created in EKS is defined in file ```main.tf```. Search for variable ```"project_name```. If you update it there, update the command above too.  
Note3: the terraform state file is being saved in the local folder. So don't waste this folder until after you deleted the infrastructure.  