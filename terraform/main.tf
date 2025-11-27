# ============================================
# UFBank - Terraform AWS
# ============================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ============================================
# VPC
# ============================================
resource "aws_vpc" "ufbank_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name        = "ufbank-vpc-${var.environment}"
    Project     = "UFBank"
    Environment = var.environment
  }
}

# ============================================
# Subnet Pública
# ============================================
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ufbank_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "ufbank-public-subnet"
  }
}

# ============================================
# Internet Gateway
# ============================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ufbank_vpc.id
  
  tags = {
    Name = "ufbank-igw"
  }
}

# ============================================
# Route Table
# ============================================
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ufbank_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "ufbank-public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ============================================
# Security Group
# ============================================
resource "aws_security_group" "ufbank_sg" {
  name        = "ufbank-sg"
  description = "Security group para UFBank"
  vpc_id      = aws_vpc.ufbank_vpc.id
  
  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ufbank-sg"
  }
}

# ============================================
# EC2 Instance
# ============================================
resource "aws_instance" "ufbank_server" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ufbank_sg.id]
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              
              # Rodar container
              docker run -d -p 80:80 nginx:alpine
              
              # Criar página simples
              echo "<h1>UFBank - Provisionado com Terraform!</h1>" > /usr/share/nginx/html/index.html
              EOF
  
  tags = {
    Name = "ufbank-server"
  }
}

# ============================================
# Outputs
# ============================================
output "vpc_id" {
  value = aws_vpc.ufbank_vpc.id
}

output "public_ip" {
  value = aws_instance.ufbank_server.public_ip
}

output "url" {
  value = "http://${aws_instance.ufbank_server.public_ip}"
}
