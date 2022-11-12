include "root" {
  path = find_in_parent_folders()
}

inputs = {
  region  = "us-east-1"
  db_name = "hozgans_blog_dev"

  tags = {
    Name = "hozgan-blog-dev"
  }
}