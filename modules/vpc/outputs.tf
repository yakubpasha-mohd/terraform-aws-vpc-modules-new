############################################
# VPC Module - outputs.tf
############################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

# OPTIONAL: expose private subnet list if you create multiple private subnets
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private_subnet.*.id
}