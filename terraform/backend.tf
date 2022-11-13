terraform {
  backend "s3" {
    bucket               = "hozgans-terraform-bucket-for-remote-states"
    key                  = "hozgans-app/terraform.tfstate"
    region               = "us-east-1"
    dynamodb_table       = "hozgans-terraform-table-for-lock"
    encrypt              = true

    # Then, when using the dev workspace, the state file will be s3://remote-states-bucket/hozgans-app/terraform.tfstated/dev/terraform.tfstate.
    workspace_key_prefix = "terraform.tfstated"
  }
}