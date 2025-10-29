aws_region          = "us-east-1"
availability_zone   = "us-east-1a"
project_name        = "demo"
environment         = "dev"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

tags = {
  Owner = "yakub"
}
