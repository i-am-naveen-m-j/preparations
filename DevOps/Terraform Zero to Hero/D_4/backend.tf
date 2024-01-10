
## 1st time comment /*       */ becuse s3 buckt and dynamo DB not yet created throws error


/*


terraform {
  backend "s3" {
    bucket         = "naveen-s3-demo-abc-1" # change this
    key            = "naveen/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}


*/