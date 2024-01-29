# Configure the AWS provider
provider "aws" {
  region = "us-west-2" # Change this to your preferred region
}

# Find the latest Ubuntu AMI
data "aws_ami" "ubuntu_x86" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  #filter {
  #  name   = "architecture"
  #  values = ["amd64"]
  #}
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_ami" "ubuntu_arm" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create a security group that allows SSH and HTTP access
resource "aws_security_group" "sg1" {
  name        = "multi-arch-tester"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = "vpc-0830f668b1c83f562"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["187.74.136.99/32"] # Change this to your IP address or a more restrictive range
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance using the Ubuntu AMI and the security group
resource "aws_instance" "x86" {
  ami = data.aws_ami.ubuntu_x86.id
  instance_type = "t2.micro" 
  associate_public_ip_address = true
  key_name = "gtl-dev-rsa-gitlab"
  subnet_id = "subnet-07c400314610bd284"
  vpc_security_group_ids = [
    aws_security_group.sg1.id
  ]
  tags = {
    Name = "test-ec2-x86"
  }
  user_data = file("cloud-init.sh")
}

resource "aws_instance" "arm" {
  ami = data.aws_ami.ubuntu_arm.id
  instance_type = "c6g.medium"
  associate_public_ip_address = true
  key_name = "gtl-dev-rsa-gitlab"
  subnet_id = "subnet-07c400314610bd284"  
  vpc_security_group_ids = [
    aws_security_group.sg1.id
  ]
  tags = {
    Name = "test-ec2-arm"
  }
  user_data = file("cloud-init.sh")
}

# The public subnets in that VPC need this route table, otherwise the docker repo is unreachable
resource "aws_route" "r" {
  route_table_id            = "rtb-0ac8d5ab4870ca26c"
  destination_cidr_block    = "10.163.204.0/22"
  vpc_peering_connection_id = "pcx-07e0c2a067bb7c08f"
}

output "x86-id" {
  description = "ID of the x86 EC2 instance"
  value = aws_instance.x86.id
}
output "arm-id" {
  description = "ID of the arm EC2 instance"
  value = aws_instance.arm.id
}

output "message1" {
  value = "Connect to the x86 instance using: ssh ubuntu@${aws_instance.x86.public_ip} -i /home/juliano/googledrive/dinheiro/BairesDev/ViaPath/keys/gtl-dev-rsa-gitlab.pem"
}
output "message2" {
  value = "Connect to the ARM instance using: ssh ubuntu@${aws_instance.arm.public_ip} -i /home/juliano/googledrive/dinheiro/BairesDev/ViaPath/keys/gtl-dev-rsa-gitlab.pem"
}

