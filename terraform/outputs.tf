output "db_username" {
    value = module.blog.db_username
}

output "db_password" {
    value = module.blog.db_password
    sensitive = true
}

output "db_address" {
    value = module.blog.db_address
}

output "db_name" {
    value = module.blog.db_name
}

output "web_address" {
    value = module.blog.web_address
}
