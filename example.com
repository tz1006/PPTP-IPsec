server
{
    listen 80 default_server;
    listen 443 ssl;
    #listen [::]:80 default_server;
    
    # root /var/www/html;
    server_name   example.com;
    # access_log   /var/log/nginx/example.com.log;
    
    # RSA certificate
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    
    # Redirect non-https traffic to https
    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }
    
    location / {
        proxy_pass          https://proxy.com;
        proxy_set_header Accept-Language "zh-CN"; 
        #proxy_set_header Accept-Encoding "";
        
        #sub_filter_once off;
        #sub_filter_types text/html;
        #sub_filter 'Google' 'your_string';
    }
}
