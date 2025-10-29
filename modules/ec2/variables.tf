############################################
# EC2 Module - variables.tf
############################################

variable "ami" {
  description = "AMI ID to launch"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID to launch instance into"
  type        = string
}

# rename if you haven't already
variable "priv_subnet_id" {
  description = "Private Subnet ID to launch private instance into"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID (required if module should create a default security group)"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Existing EC2 key pair name for SSH (optional)"
  type        = string
  default     = ""
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP on launch"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "List of existing security group IDs to attach to the instance (optional). If empty and create_default_sg=true a default SG will be created."
  type        = list(string)
  default     = []
}

variable "create_default_sg" {
  description = "Create a default security group if security_group_ids is empty"
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = <<-EOT
  List(object) of ingress rules used when creating the default security group.
  Each object: { from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional string }
  EOT
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), ["0.0.0.0/0"])
    description = optional(string)
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "SSH" },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTP" }
  ]
}


variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "root_volume_size" {
  description = "Root EBS volume size (GiB)"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Root EBS volume type"
  type        = string
  default     = "gp3"
}

variable "delete_on_termination" {
  description = "Whether root volume should be deleted on termination"
  type        = bool
  default     = true
}

variable "create_data_volume" {
  description = "Whether to create and attach an additional EBS data volume"
  type        = bool
  default     = false
}

variable "data_volume_size" {
  description = "Size (GiB) of the additional EBS data volume"
  type        = number
  default     = 50
}

variable "data_volume_type" {
  description = "Type of the additional EBS data volume"
  type        = string
  default     = "gp3"
}

variable "data_volume_encrypted" {
  description = "Whether additional EBS data volume is encrypted"
  type        = bool
  default     = false
}

variable "data_volume_device_name" {
  description = "Device name for the attached data volume (e.g. /dev/sdh)"
  type        = string
  default     = "/dev/sdh"
}



variable "create_before_destroy" {
  description = "Whether to create before destroy for the EC2 resource (avoid downtime during replacement). Set false for limited quota."
  type        = bool
  default     = true
}
