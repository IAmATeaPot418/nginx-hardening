#!/bin/bash
# echo on
set +o xtrace 

#Ensure the sciprt is run as root

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

# Export environment variables used as host header restrictions by NGINX
if [ -z "$MYIP" ]
then
    echo "Please enter the IP address used to host the website: "
    read myipaddress
    export MYIP=$myipaddress
fi

# Configure the NGINX repo to pull down the latest nginx package

dnf update -y && dnf install dnf-utils -y
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/rhel/8/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF

# Install git
dnf install git -y
# Install NGINX
cd /tmp
git clone https://github.com/IAmATeaPot418/nginx-hardening.git

dnf install nginx -y 

# remove existing nginx.conf file
sudo rm -f /etc/nginx/nginx.conf

#remove index.html
sudo rm -f /usr/share/nginx/html/index.html

# remove page for server errors
sudo rm -f /usr/share/nginx/html/50x.html

#move error messages to config
sudo mv nginx-hardening/50x.html /usr/share/nginx/html/50x.html

#copy nginx.conf hosted on repo and make it the NGINX configuration file
mv nginx-hardening/nginx.conf /etc/nginx/nginx.conf

#copy index.html hosted on repo and make it the NGINX index.html file.
sudo mv nginx-hardening/index.html /usr/share/nginx/html/index.html

#copy client side error message and server error messages
sudo mv nginx-hardening/40x.html /usr/share/nginx/html/40x.html

#remove the cloned repository because we only needed one file from it.
rm -rf /tmp/nginx-hardening

#add the public ip address to the server name directive to ensure you can only access NGINX when the host header is that name. You will only be able to access as this IP address. 
sed -i "s/server_name[^;]*;/server_name $MYIP;/" /etc/nginx/nginx.conf

#change directories to the directory we want the certificate to be installed in.
cd /etc/nginx

#create a self-signed certificate. You will have to type `thisisunsafe` in the browser to get to the site the first time. 
sudo openssl req -x509 -nodes -days 365 -subj "/C=US/ST=CA/L=SantaClara/O=Jamie/OU=Personal/CN=ILikeNginx" -newkey rsa:2048 -keyout /etc/nginx/nginx-selfsigned.key -out /etc/nginx/nginx-selfsigned.crt

# Enable nginx service to persist on reboots
sudo systemctl enable nginx

# Start NGINX service
sudo systemctl start nginx

