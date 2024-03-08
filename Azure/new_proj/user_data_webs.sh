#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo su
echo "<h1>Hello From Jared's Terraform created Web Server :)</h1>" > /var/www/html/index.html