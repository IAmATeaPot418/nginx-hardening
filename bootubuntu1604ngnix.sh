#/bin/bash
sudo wget http://nginx.org/keys/nginx_signing.key
sleep 1
sudo apt-key add nginx_signing.key
sleep 2
sudo su
cd /etc/apt
sudo echo "deb http://nginx.org/packages/ubuntu xenial nginx
deb-src http://nginx.org/packages/ubuntu xenial nginx" >> /etc/apt/sources.list
sleep 1
sudo apt-get update
sleep 15
sudo apt-get install nginx
sleep 5
/etc/init.d/ngnix restart
