output "db_username" {
    value = aws_db_instance.mysql.username
}

output "db_password" {
    value = var.db_password
    sensitive = true
}

output "db_address" {
    value = aws_db_instance.mysql.address
}

output "db_name" {
    value = aws_db_instance.mysql.db_name
}

output "web_address" {
    value = aws_eip.eip.address
}
