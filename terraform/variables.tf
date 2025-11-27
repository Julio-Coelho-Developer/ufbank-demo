# ============================================
# UFBank Terraform Variables
# ============================================

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "app_port" {
  description = "External port for UFBank application"
  type        = number
  default     = 3000

  validation {
    condition     = var.app_port > 1024 && var.app_port < 65535
    error_message = "App port must be between 1024 and 65535."
  }
}

variable "aws_region" {
  description = "AWS Region for resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
}

variable "enable_monitoring" {
  description = "Enable CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 35
    error_message = "Backup retention must be between 1 and 35 days."
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "UFBank"
    Team        = "DevOps"
    CostCenter  = "Engineering"
    Terraform   = "true"
  }
}

# Multi-Cloud Configuration
variable "enable_aws" {
  description = "Enable AWS resources"
  type        = bool
  default     = false
}

variable "enable_azure" {
  description = "Enable Azure resources"
  type        = bool
  default     = false
}

variable "enable_gcp" {
  description = "Enable GCP resources"
  type        = bool
  default     = false
}

# Container Configuration
variable "container_cpu" {
  description = "CPU units for containers"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory (in MB) for containers"
  type        = number
  default     = 512
}

variable "replicas" {
  description = "Number of application replicas"
  type        = number
  default     = 2

  validation {
    condition     = var.replicas >= 1 && var.replicas <= 10
    error_message = "Replicas must be between 1 and 10."
  }
}

# Security Configuration
variable "enable_ssl" {
  description = "Enable SSL/TLS"
  type        = bool
  default     = true
}

variable "allowed_ips" {
  description = "List of allowed IP addresses"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_waf" {
  description = "Enable Web Application Firewall"
  type        = bool
  default     = false
}

# Database Configuration (for future expansion)
variable "db_instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "ufbank"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = ""
  sensitive   = true
}
