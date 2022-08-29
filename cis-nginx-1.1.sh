#!/bin/bash
# echo on
set +o xtrace 

#Ensure the sciprt is run as root

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root. Please sudo su and try again. Now exiting...' >&2
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
echo 'Setting up NGINX repository for installation...' 
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
echo 'Installing Git to procceed with installation...' 
dnf install git -y
# Clone GitHub Repo
echo 'Cloning GitHub repo with NGINX Configuration...' 
cd /tmp
git clone https://github.com/IAmATeaPot418/nginx-hardening.git
#Install NGINX
echo 'Now installing NGINX...' 
dnf install nginx -y 

echo 'Removing NGINX default configuration files' 
# remove existing nginx.conf file
rm -f /etc/nginx/nginx.conf
# Remove default nginx config included in install
rm -f /etc/nginx/conf.d/default.conf
#remove index.html
rm -f /usr/share/nginx/html/index.html
# remove page for server errors
rm -f /usr/share/nginx/html/50x.html

echo 'Copying configuraiton files for nginx to the host...' 
#move error messages to config
mv nginx-hardening/50x.html /usr/share/nginx/html/50x.html

#copy nginx.conf hosted on repo and make it the NGINX configuration file
mv nginx-hardening/nginx.conf /etc/nginx/nginx.conf

#copy index.html hosted on repo and make it the NGINX index.html file.
mv nginx-hardening/index.html /usr/share/nginx/html/index.html

#copy client side error message and server error messages
mv nginx-hardening/40x.html /usr/share/nginx/html/40x.html

#remove the cloned repository because we only needed one file from it.
echo 'Cleaning up unessesary files...' 
cd /etc/nginx
rm -rf /tmp/nginx-hardening

echo 'Configuring authroized host headers' 
#add the public ip address to the server name directive to ensure you can only access NGINX when the host header is that name. You will only be able to access as this IP address. 
sed -i "s/server_name[^;]*;/server_name $MYIP;/" /etc/nginx/nginx.conf

echo 'Creating a self-signed certificate...' 
#create a self-signed certificate. You will have to type `thisisunsafe` in the browser to get to the site the first time. 
sudo openssl req -x509 -nodes -days 365 -subj "/C=US/ST=CA/L=SantaClara/O=Jamie/OU=Personal/CN=ILikeNginx" -newkey rsa:2048 -keyout /etc/nginx/nginx-selfsigned.key -out /etc/nginx/nginx-selfsigned.crt

echo 'Enableing NGINX...' 
# Enable nginx service to persist on reboots
sudo systemctl enable nginx

# Start NGINX service
sudo systemctl start nginx

echo "NGINX has been successfully installed at $MYIP please go to https://$MYIP and type in `thisisunsafe` to bypass certificate issues and access the webstie. Now exiting..."
exit 0