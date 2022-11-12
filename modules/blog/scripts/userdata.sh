#!/bin/bash

yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
yum install amazon-linux-extras -y
amazon-linux-extras | grep php
yum install amazon-linux-extras php7.4
amazon-linux-extras enable php7.4
yum clean metadata
yum install php-cli php-pdo php-fpm php-json php-mysqlnd -y
yum install php php-common php-pear -y
yum install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip}  -y
yum install php-curl php-mbstring php-intl php-opcache php-soap php-gd php-xml php-mysqli -y
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
cd /var/www/html
tar xzvf latest.tar.gz
mv wordpress/* ./
chown -R apache:apache /var/www/html/*
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
rm -rf index.html
systemctl restart httpd
systemctl reload httpd 
sed -i 's/database_name_here/${db_name}/' /var/www/html/wp-config.php
sed -i 's/username_here/${db_user}/' /var/www/html/wp-config.php
sed -i 's/password_here/${db_pass}/' /var/www/html/wp-config.php
sed -i 's/localhost/${db_host}:${db_port}/' /var/www/html/wp-config.php
systemctl restart httpd
systemctl reload httpd
