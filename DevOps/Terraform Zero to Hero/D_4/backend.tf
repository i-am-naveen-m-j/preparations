terraform {
  backend "s3" {
    bucket         = "naveen-s3-demo-abc" # change this
    key            = "naveen/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}