####################################
# Dev environment - outputs.tf
####################################

output "region" {
  description = "AWS region used for deployment"
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}


