
resource "aws_key_pair" "keypair1" {
  key_name   = "${var.stack}-keypairs"
  public_key = file(var.ssh_key)
}

locals {
  module_path = abspath(path.module)
}

data "template_file" "userdata" {
  template = file("${local.module_path}/scripts/userdata.sh")

  vars = {
    db_port = aws_db_instance.mysql.port
    db_host = aws_db_instance.mysql.address
    db_user = var.db_username
    db_pass = var.db_password
    db_name = var.db_name
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.mysql.id]
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  skip_final_snapshot    = true
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  depends_on = [
    aws_db_instance.mysql,
  ]

  key_name                    = aws_key_pair.keypair1.key_name
  vpc_security_group_ids      = [aws_security_group.web.id]
  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = true

  # user_data = file("${local.module_path}/scripts/userdata.sh")
  user_data = data.template_file.userdata.rendered

  tags = {
    Name = "hozgans blog"
  }

  # provisioner "file" {
  #   content     = data.template_file.userdata.rendered
  #   destination = "/tmp/userdata.sh"

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host        = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/userdata.sh",
  #     "/tmp/userdata.sh",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host        = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }

  # provisioner "file" {
  #   content     = data.template_file.userdata.rendered
  #   destination = "/tmp/wp-config.php"

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host        = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo cp /tmp/wp-config.php /var/www/html/wp-config.php",
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     host        = self.public_ip
  #     private_key = file(var.ssh_priv_key)
  #   }
  # }

  timeouts {
    create = "20m"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}