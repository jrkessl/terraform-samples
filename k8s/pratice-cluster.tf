resource "aws_iam_role" "role1" {
  name = "eks-role-${var.project_name}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "mycluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.role1.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
# resource "aws_iam_role_policy_attachment" "${var.project_name}-AmazonEKSVPCResourceController" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#   role       = aws_iam_role.role1.name
# }

resource "aws_eks_cluster" "mycluster" {
  name     = "${var.project_name}"
  role_arn = aws_iam_role.role1.arn

  vpc_config {
    subnet_ids = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id, aws_subnet.mysubnet3.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.mycluster-AmazonEKSClusterPolicy,
  ]

  version = var.kubernetes_version
}

output "endpoint" {
  value = aws_eks_cluster.mycluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.mycluster.certificate_authority[0].data
}


resource "aws_eks_node_group" "mynodegroup" {
  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = "${var.project_name}-nodegroup"
  node_role_arn   = aws_iam_role.nodegroup-role.arn
  # subnet_ids      = aws_subnet.example[*].id
  subnet_ids      = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id, aws_subnet.mysubnet3.id]


  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = [var.instance_type]
  # instance_types = ["t3.micro"]

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }  

  update_config {
    max_unavailable = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.mycluster-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.mycluster-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.mycluster-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "nodegroup-role" {
  name = "${var.project_name}-nodegroup-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "mycluster-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodegroup-role.name
}

resource "aws_iam_role_policy_attachment" "mycluster-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodegroup-role.name
}

resource "aws_iam_role_policy_attachment" "mycluster-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodegroup-role.name
}