data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "myVpc" {          // Creating our VPC.
  cidr_block = var.cidr_blocks.blockA // Get the CIDR block from the variables file.
  tags = {
    Name = "${var.project_name}-vpc" // Naming our VPC after the name of the solution we are creating it for.
  }
}

// Creating one internet gateway.
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myVpc.id
  tags = {
    Name = "${var.project_name}-igw" // Naming this resource after the name of the solution we are creating it for.
  }
}

// Creating subnets.
resource "aws_subnet" "mysubnet1" {           // Create one subnet.
  vpc_id            = aws_vpc.myVpc.id        // Creates this in the same VPC we just create above
  cidr_block        = var.cidr_blocks.blockA1 // Get the CIDR block from the list of variables.
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "subnet-${var.project_name}-public-0" // Naming our VPC after the name of the solution we are creating it for.
  }                                              // Also attaching at the end the letter of the availability zone.
  map_public_ip_on_launch = true
}
resource "aws_subnet" "mysubnet2" {           
  vpc_id            = aws_vpc.myVpc.id        
  cidr_block        = var.cidr_blocks.blockA2 
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "subnet-${var.project_name}-public-1" 
  }                             
  map_public_ip_on_launch = true                  
}
resource "aws_subnet" "mysubnet3" {           
  vpc_id            = aws_vpc.myVpc.id        
  cidr_block        = var.cidr_blocks.blockA3 
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "subnet-${var.project_name}-public-2" 
  }                             
  map_public_ip_on_launch = true                 
}

// Creating route tables, one public, one private
resource "aws_route_table" "myRoutetablePublic" {
  vpc_id = aws_vpc.myVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.project_name}-public-rt" // Naming this resource after the name of the solution we are creating it for.
  }
}

// Associate subnets to the route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myRoutetablePublic.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.myRoutetablePublic.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.mysubnet3.id
  route_table_id = aws_route_table.myRoutetablePublic.id
}

// Create a security group 
resource "aws_security_group" "sg1" {
  name   = "${var.project_name}-sg"
  vpc_id = aws_vpc.myVpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}







