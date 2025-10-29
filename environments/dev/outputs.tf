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

output "public_subnet_id" {
  description = "Public subnet ID created by the VPC module"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID created by the VPC module"
  value       = module.vpc.private_subnet_id
}

# If you enable an EC2 module, you can add:
# output "ec2_instance_id" {
#   value = module.ec2.instance_id
# }
