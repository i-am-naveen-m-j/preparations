
/*
provider "aws" {
  region = "us-east-1"
} 
*/
###Not mandotory above providers BCZ passed inside module main.tf file // mention any one place###

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-03f4878755434977f" # replace this
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-0663f9d6805455b28" # replace this
}