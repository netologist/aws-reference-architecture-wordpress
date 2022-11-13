terraform {
  backend "s3" {
    bucket               = "hozgans-terraform-bucket-for-remote-states"
    key                  = "terraform.tfstate"
    workspace_key_prefix = "tf-state" # Then, when using the myapp-dev workspace, the state file will be s3://devops/tf-state/myapp-dev/terraform.tfstate.
    region               = "us-east-1"
    dynamodb_table       = "hozgans-terraform-table-for-lock"
    encrypt              = true
  }
}