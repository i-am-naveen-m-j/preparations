
/*

provider "aws" {
  region = "ap-south-1"
}

*/



variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.small"
    "prod" = "t2.nano"
  }

  
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}


## Steps ###
/*
 Day-6 | Terraform Workspaces Demo | Dev - QA - Stage |
for different enveranmentes

terraform workspace new dev
terraform workspace new stage
terraform workspace new prod
--
terraform workspace select dev
terraform workspace select stage
terraform workspace select prod

terraform workspace show
-------
terraform init
terraform plan
terraform apply
terraform destroy
-----

terraform apply -var-file=dev.tfvar
terraform apply -var-file=prod.tfvar
//
  "dev" = "t2.micro"
    "stage" = "t2.small"
    "prod" = "t2.nano"
	///





*/