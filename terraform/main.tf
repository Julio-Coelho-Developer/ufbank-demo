# ============================================
# UFBank Multi-Cloud Infrastructure
# Terraform Configuration
# ============================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# ============================================
# Provider AWS (Opcional - comentado por padrão)
# ============================================
# provider "aws" {
#   region = var.aws_region
#   
#   default_tags {
#     tags = {
#       Project     = "UFBank"
#       Environment = var.environment
#       ManagedBy   = "Terraform"
#     }
#   }
# }

# ============================================
# Docker Provider (Local Demo)
# ============================================
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# ============================================
# Docker Network
# ============================================
resource "docker_network" "ufbank_network" {
  name = "ufbank-network"
}

# ============================================
# Docker Image - UFBank App
# ============================================
resource "docker_image" "ufbank_app" {
  name = "ufbank-app:latest"
  build {
    context    = "../app"
    dockerfile = "Dockerfile"
    tag        = ["ufbank-app:latest"]
    label = {
      project = "ufbank"
      version = "1.0.0"
    }
  }
}

# ============================================
# Docker Container - UFBank Application
# ============================================
resource "docker_container" "ufbank_app" {
  name  = "ufbank-app-${var.environment}"
  image = docker_image.ufbank_app.image_id

  ports {
    internal = 80
    external = var.app_port
  }

  networks_advanced {
    name = docker_network.ufbank_network.name
  }

  labels {
    label = "com.ufbank.environment"
    value = var.environment
  }

  labels {
    label = "com.ufbank.service"
    value = "frontend"
  }

  restart = "unless-stopped"

  healthcheck {
    test         = ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost/"]
    interval     = "30s"
    timeout      = "3s"
    start_period = "5s"
    retries      = 3
  }
}

# ============================================
# Docker Image - Nginx Load Balancer
# ============================================
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

# ============================================
# Docker Container - Load Balancer
# ============================================
resource "docker_container" "load_balancer" {
  name  = "ufbank-loadbalancer-${var.environment}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.ufbank_network.name
  }

  labels {
    label = "com.ufbank.environment"
    value = var.environment
  }

  labels {
    label = "com.ufbank.service"
    value = "loadbalancer"
  }

  restart = "unless-stopped"

  upload {
    content = templatefile("${path.module}/nginx.conf.tpl", {
      backend_host = docker_container.ufbank_app.name
    })
    file = "/etc/nginx/conf.d/default.conf"
  }
}

# ============================================
# Exemplo de recursos AWS (comentado)
# Descomente para usar com AWS
# ============================================

# # VPC
# resource "aws_vpc" "ufbank_vpc" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   
#   tags = {
#     Name = "ufbank-vpc-${var.environment}"
#   }
# }

# # Subnet Pública
# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.ufbank_vpc.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "${var.aws_region}a"
#   map_public_ip_on_launch = true
#   
#   tags = {
#     Name = "ufbank-public-subnet"
#   }
# }

# # Internet Gateway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.ufbank_vpc.id
#   
#   tags = {
#     Name = "ufbank-igw"
#   }
# }

# # Security Group
# resource "aws_security_group" "app_sg" {
#   name        = "ufbank-app-sg"
#   description = "Security group for UFBank application"
#   vpc_id      = aws_vpc.ufbank_vpc.id
#   
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   
#   tags = {
#     Name = "ufbank-app-sg"
#   }
# }

# # EC2 Instance
# resource "aws_instance" "app_server" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.public_subnet.id
#   vpc_security_group_ids = [aws_security_group.app_sg.id]
#   
#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y docker
#               systemctl start docker
#               systemctl enable docker
#               docker run -d -p 80:80 ufbank-app:latest
#               EOF
#   
#   tags = {
#     Name = "ufbank-app-server"
#   }
# }

# # S3 Bucket para logs
# resource "aws_s3_bucket" "logs" {
#   bucket = "ufbank-logs-${var.environment}"
#   
#   tags = {
#     Name = "ufbank-logs"
#   }
# }

# # S3 Bucket Encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
#   bucket = aws_s3_bucket.logs.id
#   
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }
