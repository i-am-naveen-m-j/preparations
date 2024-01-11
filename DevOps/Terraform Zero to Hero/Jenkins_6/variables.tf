variable "region" {
  default = "ap-south-1"
}

variable "cidr" {
  default = "10.1.0.0/16"
}


variable "cidr_sub1"{
  default = "10.1.0.0/24"

}
variable "az_sub1"{
default = "ap-south-1a"
}



variable "ami" {
  default = "ami-03f4878755434977f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "terraform-demo-naveen_2"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}

variable "username" {
  default = "ubuntu"
}




##ove ride like   (e.g., terraform apply -var 'region=us-east-1').
##  terraform output public_ip
