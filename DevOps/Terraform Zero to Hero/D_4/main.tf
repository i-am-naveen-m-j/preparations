provider "aws" {
  region = "ap-south-1"
}

/*
resource "aws_instance" "abhishek" {
  instance_type = "t2.micro"
  ami = "ami-03f4878755434977f" # change this
  subnet_id = "subnet-0663f9d6805455b28" # change this
}
*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "naveen-s3-demo-abc" # change this
}


/*
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }



}

*/