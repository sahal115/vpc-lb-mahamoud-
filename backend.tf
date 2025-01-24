terraform {
  backend "s3"{
  bucket = "my-aws-mahamoud"
  key = "week10/terraform.tfstate"
  dynamodb_table = "terraform-lock1"
  region = "us-east-1"
  profile ="default"
  encrypt = true
    }
  }
