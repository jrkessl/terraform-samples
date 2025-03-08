# Terraform sample: Kubernetes cluster in AWS EKS service

This is all set to launch a Kubernetes cluster in AWS EKS service. From the VPC, subnets, route tables, all the way to the cluster itself and 1 cluster node, all gets created by this code.  

How to launch: 
1) Download this project's files. 
2) Have [terraform](https://www.terraform.io/) installed in your workstation.
3) Have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed in your workstation. 
4) Have your AWS [access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) for your AWS IAM user installed in your workstation.
5) Have the [kubectl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html) executable installed in your workstation.
6) Go to the project folder (`terraform-samples/k8s`) and do: 
7) Get your public IP on address [checkip.amazonaws.com](https://checkip.amazonaws.com). Open up file `terraform.tfvars` and make sure to put your IP in the value of variable  `my_ip`. This will be used for the AWS security groups (firewalls). In this file you can also change the region where the cluster is deployed.  
8) Do `terraform init` to initialize Terraform (you still need to be in `terraform-samples/k8s` folder).
9) Do `terraform apply` to launch everything. Confirm object creation when prompted. Now wait for provisioning. It takes about 10 minutes.
10) After Terraform finishes, run this command to configure your local kubectl executable to point to the cluster you just created. If you changed the region in step 7, change it in this command too.   
`aws eks update-kubeconfig --region sa-east-1 --name TestK8sCluster`

That's it! You are connected to your test cluster. Now try commands such as: 
```
kubectl config current-context
kubectl version
kubectl get ns 
kubectl get all --all-namespaces
kubectl apply -f ...
```
If you change some cluster setting in the .tf files, apply the changes to your existing cluster by running again `terraform apply`. Only changed settings will be reapplied. The entire cluster is not recreated.
Once you are done testing, destroy (delete) your cluster with `terraform destroy`. Confirm when prompted.

### Troubleshooting

You got `Error: "x.x.x.x/32" is not a valid CIDR block: invalid CIDR address: x.x.x.x/32`  
  
Solution: You forgot to put your IP in the variables file. See above about it.  
  
You got `An error occurred (ResourceNotFoundException) when calling the DescribeCluster operation: No cluster found for name: TestK8sCluster.`  
  
Solution: This can be caused by many things. One good possibility is that you changed the region in step 7 but not in step 10, or vice-versa. If it is not just that, you need to search why is the cluster not where it is expected to be. I suggest you log in to the AWS console, go to the EKS service in the correct region and look for it: where is it, and has its name been changed?

### IMPORTANT
#### This is billable cloud infrastructure.
This is cloud infrastructure. The infrastructure you are launching here is not eligible to the free tier, even if you have a free tier-eligible AWS account. As of this writing, the Kubernetes cluster on AWS EKS costs $0,10/hour, and the EC2 we are launching here, t3.medium, costs about $0.06/hour. It's cheap. Unless you forget it on and move on. Then it can cost you. Always delete everything at the end of the exercise. Don't leave it on thinking you will come back to your exercise later. That is risky. After all, the magic of infrastructure as code is precisely the ability to delete and recreate everything, in an on-demand and predictable manner. 
#### The Terraform state file is local. Do not delete local files before deleting the cluster.
If you are new to Terraform, be aware: Terraform creates a state file. This file is necessary to destroy the cloud infrastructure when you run `terraform destroy`. By default, the terraform state file is saved locally. If you delete the local project folder, you lose the state file, and now can't use `terraform destroy`. You will have to go to the AWS console and delete everything manually. So just don't delete the local project files until after you are done playing with your cluster. 
