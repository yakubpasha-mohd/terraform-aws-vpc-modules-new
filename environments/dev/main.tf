####################################
# Dev environment - main.tf
####################################

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  # backend configuration should live in envs/dev/backend.tf
  # (do not put backend config here to keep it reusable)
}

provider "aws" {
  region = var.aws_region
}

# (Optional) helpful data sources
data "aws_caller_identity" "me" {}

# VPC module - uses modules/vpc
module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  project_name        = var.project_name

  # Merge environment tag with common tags passed to module
  tags = merge(var.tags, { Environment = var.environment })
}

module "ec2-public" {
  source         = "../../modules/ec2"
  ami            = "ami-0c02fb55956c7d316" # change to an up-to-date AMI for your region
  instance_type  = "t3.micro"
  subnet_id      = module.vpc.public_subnet_id
  vpc_id         = module.vpc.vpc_id
  key_name       = var.key-name         # optional
  associate_public_ip = true
  project_name   = var.project_name
  environment    = var.environment
  tags = merge(var.tags, {
    Role = "web"
  })

  # optional
  create_data_volume = false
}


# Private EC2 (in private subnet)
module "ec2_private" {
  source               = "../../modules/ec2"
  ami                  = "ami-0c02fb55956c7d316"
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.private_subnet_id    # ensure this output exists
  vpc_id               = module.vpc.vpc_id
  key_name             = var.key-name
  associate_public_ip  = false                           # private instance should not have public IP
  project_name         = var.project_name
  environment          = var.environment
  tags                 = merge(var.tags, { Role = "app", Tier = "private" })
  create_data_volume   = false
}