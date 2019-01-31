server
{
    listen 80;
    listen 443 ssl;
    #listen [::]:80 default_server;
    
    root /var/www/example.com;
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
        proxy_pass          https://website.com;
        proxy_set_header Accept-Language "zh-CN";
        proxy_set_header Accept-Encoding "";
        
        #proxy_set_header Host $host;
        #proxy_set_header X-Real-IP $remote_addr;
        #proxy_set_header User-Agent $http_user_agent;

        #proxy_ssl_server_name on;
        #proxy_ssl_session_reuse off;

        #sub_filter_once off;
        #sub_filter_types *;
        #sub_filter 'website.com' 'example.com/static';

        #more_set_headers 'Access-Control-Allow-Origin: *';
        
    }

    #location /dir  {
    #    #return 301 https://www.website.com;
    #    rewrite ^/(.*)$  https://www.website.com  permanent;
    #}
    
    #location /example_dir/ {
    #    proxy_pass          https://website.com;
    #    try_files $uri $uri/ =404;
    #}

}
