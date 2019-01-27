#!/bash/sh
# 用法 bash nginx.sh  yourdomain.com proxy.com

sudo apt -y update
sudo apt install -y nginx

curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/letsencrypt.sh | bash -s $1

wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/example.com -O /etc/nginx/sites-enabled/example.com

# Replace example.com
sed -i "s/example.com/$1/g" /etc/nginx/sites-enabled/example.com
# Replace proxy.com
sed -i "s/proxy.com/$2/g" /etc/nginx/sites-enabled/example.com

# Rename example.com
mv /etc/nginx/sites-enabled/example.com /etc/nginx/sites-enabled/$1

nginx -t && nginx -s reload