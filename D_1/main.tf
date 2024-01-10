provider "aws" {
    region = "ap-south-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami            = "ami-03f4878755434977f"  # Replace with a valid AMI ID for us-east-1
    instance_type  = "t2.micro"
    subnet_id      = "subnet-0663f9d6805455b28"
    key_name       = "terraform_kp"
}

