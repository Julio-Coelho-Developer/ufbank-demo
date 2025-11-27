# ============================================
# UFBank Terraform Outputs
# ============================================

output "application_url" {
  description = "URL to access the UFBank application"
  value       = "http://localhost:${var.app_port}"
}

output "load_balancer_url" {
  description = "URL to access through load balancer"
  value       = "http://localhost:8080"
}

output "container_id" {
  description = "Docker container ID"
  value       = docker_container.ufbank_app.id
}

output "container_name" {
  description = "Docker container name"
  value       = docker_container.ufbank_app.name
}

output "network_name" {
  description = "Docker network name"
  value       = docker_network.ufbank_network.name
}

output "image_id" {
  description = "Docker image ID"
  value       = docker_image.ufbank_app.image_id
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

# AWS Outputs (quando habilitado)
# output "vpc_id" {
#   description = "VPC ID"
#   value       = aws_vpc.ufbank_vpc.id
# }

# output "public_subnet_id" {
#   description = "Public subnet ID"
#   value       = aws_subnet.public_subnet.id
# }

# output "ec2_public_ip" {
#   description = "Public IP of EC2 instance"
#   value       = aws_instance.app_server.public_ip
# }

# output "security_group_id" {
#   description = "Security group ID"
#   value       = aws_security_group.app_sg.id
# }

# output "s3_bucket_name" {
#   description = "S3 bucket for logs"
#   value       = aws_s3_bucket.logs.bucket
# }

output "infrastructure_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    environment    = var.environment
    app_port      = var.app_port
    container     = docker_container.ufbank_app.name
    network       = docker_network.ufbank_network.name
    image         = docker_image.ufbank_app.name
    load_balancer = docker_container.load_balancer.name
    access_urls   = [
      "Application: http://localhost:${var.app_port}",
      "Load Balancer: http://localhost:8080"
    ]
  }
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    timestamp     = timestamp()
    terraform_version = "~> 1.0"
    managed_by    = "Terraform"
    project       = "UFBank Multi-Cloud Demo"
  }
}

output "next_steps" {
  description = "Instructions for next steps"
  value = <<-EOT
    ═══════════════════════════════════════════════════════════════
    🎉 UFBank Infrastructure Deployed Successfully!
    ═══════════════════════════════════════════════════════════════
    
    📍 Access your application at:
       • Direct: http://localhost:${var.app_port}
       • Load Balancer: http://localhost:8080
    
    🔍 Useful Docker commands:
       • View logs: docker logs ufbank-app-${var.environment}
       • Check status: docker ps | grep ufbank
       • Stop app: docker stop ufbank-app-${var.environment}
       • Restart app: docker restart ufbank-app-${var.environment}
    
    📊 Monitor your infrastructure:
       • Container stats: docker stats ufbank-app-${var.environment}
       • Network inspect: docker network inspect ufbank-network
    
    🔄 CI/CD Pipeline:
       • Push to GitHub to trigger automated deployment
       • Check GitHub Actions for pipeline status
    
    ═══════════════════════════════════════════════════════════════
  EOT
}
