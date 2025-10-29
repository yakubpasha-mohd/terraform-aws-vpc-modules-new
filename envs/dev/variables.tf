####################################
# Dev environment - variables.tf
####################################

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "project_name" {
  description = "Project name used for tags and resource names"
  type        = string
  default     = "demo"
}

variable "environment" {
  description = "Environment name (dev / staging / prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "tags" {
  description = "Map of tags applied to resources (merged by module)"
  type        = map(string)
  default = {
    Owner = "yakub"
  }
}
