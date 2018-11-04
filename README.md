# Guide to Secure NGNIX to Modern Standards

This repo will provide direction on hardening NGNIX to modern standards.

## Steps

The below steps and scripts can be used to help facilitate a the hardening of NGNIX to modern standards.

### How to install NGNIX


The following bootstrap scripts may be used to initially install NGNIX as part of an EC2 instance launch configuration. 

This is targeted for use on an Centos/Redhat 7.5 AMI. 

```
#!/bin/bash
sudo su
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=1
enabled=1
EOF
yum update -y
curl -O https://nginx.org/keys/nginx_signing.key
rpm --import https://nginx.org/keys/nginx_signing.key
sudo yum install nginx -y

```

This is targeted for use on an Ubuntu 16.04 AMI.

```
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

```

### Minimize Features, Content and Options

Limit HTTP Request Methods

```
What:

Why:

How to check:

How to fix:

References:

```
	
Restrict Allowed IP Ranges


```
What:

Why:

How to check:

How to fix:

References:

```
Restrict Ownership and group of ngnix.conf file to root
	
```
What:

Why:

How to check:

How to fix:

References:
https://dev-sec.io/baselines/nginx/

```	


Restrict Access by others to ngnix.conf
	
	
```
What:

Why:

How to check:

How to fix:

References:
https://dev-sec.io/baselines/nginx/

```	
	
	
Ensure only one NGNIX instance per envionrment 
	

```
What:

Why:

How to check:

How to fix:

References:
https://dev-sec.io/baselines/nginx/

```	
	
	
Reduce Exposure of Server Header 
	
```
What:

Why:

How to check:

How to fix:

References:
https://dev-sec.io/baselines/nginx/

```	
	
Ensure Content Security Policy is configured
	
```
What:

Why:

How to check:

How to fix:

References:
https://dev-sec.io/baselines/nginx/

```	
	
	


### Permissions and Ownership

Run worker proccess as non-privledged user

```
What:

Why:

How to check:

How to fix:

References:

```
	
Ensure NGNIX user account is locked

```
What:

Why:

How to check:

How to fix:

References:

```
	
Set ownership on NGNIX directories and files

```
What:

Why:

How to check:

How to fix:

References:

```
	
Restrict group write access to ngnix directoires

```
What:

Why:

How to check:

How to fix:

References:

```
	
	

### TLS Configuration


Redirect HTTP to HTTPS 

```
What:

Why:

How to check:

How to fix:

References:

```
	
Disable SSL 3.0
	
```
What:

Why:

How to check:

How to fix:

References:

```
Disable TLS 1.0

```
What:

Why:

How to check:

How to fix:

References:

```
	
Disable TLS 1.1

```
What:

Why:

How to check:

How to fix:

References:

```
	
Ensure TLS 1.2 is enabled

```
What:

Why:

How to check:

How to fix:

References:

```
	
Ensure TLS 1.3 is enabled

```
What:

Why:

How to check:

How to fix:

References:

```
	
Configure Stronger DHE Parameters

```
What:

Why:

How to check:

How to fix:

References:

```
	https://www.scalescale.com/tips/nginx/hardening-nginx-ssl-tsl-configuration/
	
Install a valid trusted certificate

```
What:

Why:

How to check:

How to fix:

References:

```
	
Limit permissions to servers private key

```
What:

Why:

How to check:

How to fix:

References:

```
	
Ensure only strong cipher suites are used

```
What:

Why:

How to check:

How to fix:

References:

```
	
Enable OSCP Stapling and verification

```
What:

Why:

How to check:

How to fix:

References:

```
	
Enable HTTP Strict Transport Security

```
What:

Why:

How to check:

How to fix:

References:

```
	
Disable TLS Session Resumption

```
What:

Why:

How to check:

How to fix:

References:

```
	
Configure HTTP/2.0

```
What:

Why:

How to check:

How to fix:

References:

```
	
	
	
Notes

```
	(Many of these apply to proxy, load balancer and web server differently)
	https://docs.nginx.com/nginx/admin-guide/security-controls/securing-http-traffic-upstream/
	https://docs.nginx.com/nginx/admin-guide/security-controls/terminating-ssl-http/

```
	

	
### Logging and Operations


    

Configure Log Rotation

```
What:

Why:

How to check:

How to fix:

References:

```



Install and Enable OWASP ModSecurity Core Rule Set

```
What:

Why:

How to check:

How to fix:

References:https://geekflare.com/install-modsecurity-on-nginx/

```
		 
    
Configure the Access Log
    
```
What:

Why:

How to check:

How to fix:

References:

```

Configure the Error Log

```
What:

Why:

How to check:

How to fix:

References:

```

Configure Logging for Access Logs to Syslog
    
```
What:

Why:

How to check:

How to fix:

References:

```

Configure Logging for Error Logs to syslog

```
What:

Why:

How to check:

How to fix:

References:

```
		
Ensure Buffer Overflow attack protection is enabled

```
What:

Why:

How to check:

How to fix:

References:https://dev-sec.io/baselines/nginx/

```
		
Ensure simultaneous sessions are minimized
		
```
What:

Why:

How to check:

How to fix:

References:https://dev-sec.io/baselines/nginx/

```
		
Ensure Clickjacking Protection is enabled
		
```
What:

Why:

How to check:

How to fix:

References:https://dev-sec.io/baselines/nginx/

```
		
Ensure Browser Cross Site Scripting Features are emabled
		
```
What:

Why:

How to check:

How to fix:

References:https://dev-sec.io/baselines/nginx/

```
		
Disable Content Type sniffing
		
```
What:

Why:

How to check:

How to fix:

References:https://dev-sec.io/baselines/nginx/

```	

Deny unnesssary user agents access
		
```
What:

Why:

How to check:

How to fix:

References: https://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html

```	
		
Ensure Client IPs are forwarded 

```
What:

Why:

How to check:

How to fix:

References: https://docs.gitlab.com/omnibus/settings/nginx.html
http://nginx.org/en/docs/http/ngx_http_realip_module.html

```	
		
Ensure High Risk Geolocations not needed are blocked
		
```
What:

Why:

How to check:

How to fix:

References:https://www.scalescale.com/tips/nginx/nginx-security-guide/

```	
		
		
		
		
### Enable and Configure SELINUX
		
Ensure SELINUX is enabled

```
What:

Why:

How to check:

How to fix:

```	

Ensure NGINX proccesses run under httpd_t context

```
What:

Why:

How to check:

How to fix:

```	

Ensure httpd_t context is not running in permissive mode

```
What:

Why:

How to check:

How to fix:

```	

Ensure SELINUX is enforcing

```
What:

Why:

How to check:

How to fix:

```	

    
### Notes
	1. Server name indication is configured by default starting in openssl 0.9.8j. NGNIX currently leverages openssl 1.1.1 11/4/18.Reference: 
	http://nginx.org/en/docs/http/configuring_https_servers.html
	2. SSL compression is turned off by default in nginx 1.1.6+/1.0.9+ (if OpenSSL 1.0.0+ used) and nginx 1.3.2+/1.2.2+ (if older versions of OpenSSL are used). Reference: https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html#SSL_Compression_(CRIME_attack)
 
