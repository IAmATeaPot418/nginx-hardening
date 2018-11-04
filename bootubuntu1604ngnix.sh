#/bin/bash
sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
sudo su
cd /etc/apt
sudo echo "deb http://nginx.org/packages/ubuntu xenial nginx
deb-src http://nginx.org/packages/ubuntu xenial nginx" >> /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install nginx
/etc/init.d/ngnix restart
