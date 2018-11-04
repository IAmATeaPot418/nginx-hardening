#This portion of the profile is for if you pull down the default configuration where everything is commented out
#All commands are configured in alignment with the modern mozilla profile at https://mozilla.github.io/server-side-tls/ssl-config-generator/
#There may be some deviations for improved security. These deviations will be noted.

#This command uncomments out ssl_ciphers and configures it to match the modern mozzila profile
sed -i "s/#[^s]*ssl_ciphers[^;]*;/\tssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256;/" /etc/nginx/nginx.conf

#This command uncomments out session cache and configures it to match the modern mozilla profile
sed -i "s/#[^s]*ssl_session_cache[^;]*;/\tssl_session_cache shared:SSL:50m;/" /etc/nginx/nginx.conf

#This command uncomments out session timeout and configures it to match the modern ssl mozilla profile.
#Specifies a time during which a client may reuse the session parameters and sets it to 1 day. Session expiration: An absolute timeout is defined by the total amount of time a session can be valid without restarting the session or reauthenticating. The longer a session is allowed to stay alive is correlated with the increased likelihood of success of an attacking being able to guess a valid session ID. The longer the expiration time the longer the amount of time an attacker has to guess one specific session. This sets an absolute timeout to a session.
sed -i "s/#[^s]*ssl_session_timeout[^;]*;/\tssl_session_timeout 1d;/" /etc/nginx/nginx.conf

#find current port 80 configuration and add a redirect to it so it always will redirect to 443 returning a 308 error.
sed -i "s/listen[^8]*80;/listen 80 default_server;\n\tlisten [::]:80 default_server;\n\treturn 308 https:\/\/\$host\$request_uri;/g" /etc/nginx/nginx.conf

#This portion of the profile is for if everything is already defined and you are making changes

#If your ciphers are already defined
sed -i "s/ssl_ciphers[^;]*;/ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256;/" /etc/nginx/nginx.conf

#If you already have ssl_protocols defined you can harden these to modern standards with the below command. 
#TLS 1.3 was added in NGNIX 1.13 and is not part of the Mozilla profile as of 11/3/18

sed -i "s/ssl_protocols[^;]*;/ssl_protocols TLSv1.2 TLSv1.3;/" /etc/nginx/nginx.conf

#This command changes the session match the modern mozilla profile if it is already defined

sed -i "s/ssl_session_cache[^;]*;/ssl_session_cache shared:SSL:50m;/" /etc/nginx/nginx.conf

#This command changes a pre-configured session timeout and sets it to that defined by the modern ssl mozilla profile.
#Specifies a time during which a client may reuse the session parameters and sets it to 1 day
#Session expiration: An absolute timeout is defined by the total amount of time a session can be valid without restarting the session or reauthenticating. The longer a session is allowed to stay alive is correlated with the increased likelihood of success of an attacking being able to guess a valid session ID. The longer the expiration time the longer the amount of time an attacker has to guess one specific session. This sets an absolute timeout to a session.

sed -i "s/ssl_session_timeout[^;]*;/ssl_session_timeout 1d;/" /etc/nginx/nginx.conf

#Or just put it all to the end of the file in the ssl configuration

echo "server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    ssl_certificate /etc/nginx/cert.crt;
    ssl_certificate_key /etc/nginx/nginx.key;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;
    }" >> /etc/nginx/nginx.conf
