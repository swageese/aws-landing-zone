terraform {
  backend "s3" {
    bucket         = "hemanth-landingzone-tfstate"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hemanth-landingzone-locks"
    encrypt        = true
  }
}
