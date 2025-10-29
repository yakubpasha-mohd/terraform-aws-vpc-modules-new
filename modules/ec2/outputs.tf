############################################
# EC2 Module - outputs.tf
############################################

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.this.id
}

output "instance_private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.this.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the instance (if associated)"
  value       = aws_instance.this.public_ip
}

output "instance_ami" {
  description = "AMI used for the instance"
  value       = aws_instance.this.ami
}

output "security_group_ids" {
  description = "Final security group ids attached to the instance"
  value       = local.final_security_group_ids
}

output "root_block_device" {
  description = "Root block device attributes"
  value = {
    volume_size = aws_instance.this.root_block_device[0].volume_size
    volume_type = aws_instance.this.root_block_device[0].volume_type
  }
}

output "data_volume_id" {
  description = "ID of attached data volume (if created)"
  value       = var.create_data_volume ? aws_ebs_volume.data[0].id : ""
}
##########Private EC2 Instance##############
output "private_instance_id" {
  description = "Private EC2 Instance ID"
  value       = aws_instance.private_ec2.id
}

output "private_instance_private_ip" {
  description = "Private EC2 private IP"
  value       = aws_instance.private_ec2.private_ip
}

output "private_security_group_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private_sg.id
}