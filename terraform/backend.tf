terraform {
  backend "s3" {
    bucket         = "hozgans-terraform-bucket-for-remote-states"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hozgans-terraform-table-for-lock"
    encrypt        = true
  }
}