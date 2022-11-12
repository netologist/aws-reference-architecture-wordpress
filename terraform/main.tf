resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
module "blog" {
  source = "../modules/blog"
  
  region         = var.region
  stack          = "hozgans-blog"
  db_name        = "hozgans_blog_db"
  db_username    = "hozgans_blog_user"
  db_password    = random_password.password.result
}