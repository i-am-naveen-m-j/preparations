variable "vpc_name" {
  description = "Name for the VPC"
}

variable "subnet_name" {
  description = "Name for the subnet"
}

variable "cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  default     = "10.0.0.0/24"
  description = "CIDR block for the subnet"
}

variable "region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "availability_zone" {
  default     = "ap-south-1a"
  description = "Availability Zone for the subnet"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  # Set a default AMI ID or leave it blank to pass it during Terraform apply
  default     = "ami-03f4878755434977f"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "machine_name" {
  description = "Name for the EC2 instance"
}
