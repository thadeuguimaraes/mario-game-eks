terraform {
  backend "s3" {
    bucket = "thsrematrix" # Replace with your actual S3 bucket name
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}