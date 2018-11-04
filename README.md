# Guide to Secure NGNIX to Modern Standards

This repo will provide direction on hardening NGNIX to modern standards.


# How to install NGNIX




# Minimize Features, Content and Options

	Limit HTTP Request Methods
	
	Restrict Allowed IP Ranges
	
	Restrict Ownership and group of ngnix.conf file to root
	
	
	https://dev-sec.io/baselines/nginx/
	
	Restrict Access by others to ngnix.conf
	
	
	https://dev-sec.io/baselines/nginx/
	
	
	Ensure only one NGNIX per envionrment 
	
	https://dev-sec.io/baselines/nginx/
	
	
	Reduce Exposure of Server Header 
	
	https://dev-sec.io/baselines/nginx/
	
	
	Ensure Content Security Policy is configured
	
	https://dev-sec.io/baselines/nginx/
	
	


# Permissions and Ownership

	Run worker proccess as non-privledged user
	
	Ensure NGNIX user account is locked
	
	Set ownership on NGNIX directories and files
	
	Restrict group write access to ngnix directoires
	
	

# TLS Configuration

	Redirect HTTP to HTTPS 
	
	Disable SSL 3.0
	
	Disable TLS 1.0
	
	Disable TLS 1.1
	
	Ensure TLS 1.2 is enabled
	
	Ensure TLS 1.3 is enabled
	
	Configure Stronger DHE Parameters
	https://www.scalescale.com/tips/nginx/hardening-nginx-ssl-tsl-configuration/
	
	Install a valid trusted certificate
	
	Limit permissions to servers private key
	
	Ensure only strong cipher suites are used
	
	Enable OSCP Stapling and verification
	
	Enable HTTP Strict Transport Security
	
	Disable TLS Session Resumption
	
	Configure HTTP/2.0
	
	
	(Many of these apply to proxy, load balancer and web server differently)
	https://docs.nginx.com/nginx/admin-guide/security-controls/securing-http-traffic-upstream/
	https://docs.nginx.com/nginx/admin-guide/security-controls/terminating-ssl-http/
	
# Logging and Operations

    Configure Logging for Access Logs to Syslog
    
    Configure Logging for Error Logs to syslog
    
    Configure Log Rotation
    
    Install and Enable OWASP ModSecurity Core Rule Set
		 https://geekflare.com/install-modsecurity-on-nginx/
    
    Configure the Access Log
    
    Configure the Error Log

		
    Ensure Buffer Overflow attack protection is enabled
		
		https://dev-sec.io/baselines/nginx/
		
     Ensure simultaneous sessions are minimized
		
		https://dev-sec.io/baselines/nginx/
		
     Ensure Clickjacking Protection is enabled
		
		https://dev-sec.io/baselines/nginx/
		
		Ensure Browser Cross Site Scripting Features are emabled
		
		https://dev-sec.io/baselines/nginx/
		
		Disable Content Type sniffing
		
		https://dev-sec.io/baselines/nginx/
		
		Deny unnesssary user agents access
		https://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
		
		Ensure Client IPs are forwarded 
		
		https://docs.gitlab.com/omnibus/settings/nginx.html
		http://nginx.org/en/docs/http/ngx_http_realip_module.html
		
		
		Ensure High Risk Geolocations not needed are blocked
		
		https://www.scalescale.com/tips/nginx/nginx-security-guide/
		
		
# Enable and Configure SELINUX
		
    
# Notes
	1. Server name indication is configured by default starting in openssl 0.9.8j. NGNIX currently leverages openssl 1.1.1 11/4/18.Reference: 
	http://nginx.org/en/docs/http/configuring_https_servers.html
	2. SSL compression is turned off by default in nginx 1.1.6+/1.0.9+ (if OpenSSL 1.0.0+ used) and nginx 1.3.2+/1.2.2+ (if older versions of OpenSSL are used). Reference: https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html#SSL_Compression_(CRIME_attack)
 
