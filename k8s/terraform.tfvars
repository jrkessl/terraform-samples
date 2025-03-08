# Variable values go here.

my_ip              = "x.x.x.x/32" # Your IP so that SecurityGroup (firewall) rules can be added so that you can access ports 80 or 8080 of any applications you deploy in the cluster. Must be in CIDR block notation, meaning, followed by '/32'. 
# example: 
# my_ip = "200.0.0.1/32"

aws_region         = "sa-east-1" # This is the AWS region the cluster will be deployed into. You may change this. 
kubernetes_version = "1.32"
desired_size       = 3 # How many worker instances (nodes) should the cluster have when it is created. Must be a number between min_size and max_size.
max_size           = 3 # Maximum number of worker instances (cluster nodes) in the cluster's node group.
min_size           = 1 # Minimum number of worker instances (cluster nodes) in the cluster's node group.
instance_type      = "t3.medium" # The instance types for the worker instances of this cluster. The bigger the instance type, the more CPU and RAM they have, and the more they cost. 
