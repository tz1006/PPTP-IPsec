server
{
    listen   80;
    server_name   gg.omg.tf;
    # access_log   /var/log/nginx/example.com.log;
    
    location / {
        proxy_pass          https://example.com;
        # proxy_set_header Accept-Encoding "";
        # proxy_set_header Accept-Language "zh-CN"; 
    }
}
