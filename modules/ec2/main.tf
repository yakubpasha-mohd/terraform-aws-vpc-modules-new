############################################
# EC2 Module - main.tf
############################################

# If user didn't pass security group ids, create a default SG
resource "aws_security_group" "default" {
  count       = length(var.vpc_id) > 0 && length(var.vpc_id) > 0 && length(var.vpc_id) > 0 ? (var.create_default_sg && length(var.security_group_ids) == 0 ? 1 : 0) : (var.create_default_sg && length(var.security_group_ids) == 0 ? 1 : 0)
  name        = "${var.project_name}-ec2-sg-${var.environment}"
  description = "Default security group for ${var.project_name} (${var.environment})"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = lookup(ingress.value, "cidr_blocks", ["0.0.0.0/0"])
      description = lookup(ingress.value, "description", null)
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name        = "${var.project_name}-ec2-sg"
    Environment = var.environment
  })
}

# Choose final SG IDs (either provided or created)
locals {
  final_security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : (
    var.create_default_sg ? [aws_security_group.default[0].id] : []
  )
}

# EC2 instance
resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = local.final_security_group_ids
  key_name                    = var.key_name != "" ? var.key_name : null
  associate_public_ip_address = var.associate_public_ip

  # root block device
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = var.delete_on_termination
  }

 

  tags = merge(var.tags, {
    Name        = "${var.project_name}-ec2"
    Environment = var.environment
  })

 }

# Optional EBS data volume
resource "aws_ebs_volume" "data" {
  count = var.create_data_volume ? 1 : 0

  availability_zone = data.aws_availability_zones.available.names[0]
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = var.data_volume_encrypted

  tags = merge(var.tags, {
    Name        = "${var.project_name}-ec2-data"
    Environment = var.environment
  })
}

resource "aws_volume_attachment" "data_attach" {
  count       = var.create_data_volume ? 1 : 0
  device_name = var.data_volume_device_name
  volume_id   = aws_ebs_volume.data[0].id
  instance_id = aws_instance.this.id
  force_detach = true
}

# Data source for AZ (used by EBS volume)
data "aws_availability_zones" "available" {
  state = "available"
}

