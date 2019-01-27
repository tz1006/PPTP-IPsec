#!/bash/sh
# 用法 bash letsencrypt.sh $(hostname)

OS_VERSION=$(lsb_release -r --short)
VERSION=${OS_VERSION::2}
if [ $VERSION == '18' ]
then
    # Ubuntu18 获取证书
    sudo apt-get install -y certbot
    sudo certbot certonly --standalone --agree-tos \
                   --no-eff-email \
                   --email example@gmail.com \
                   -d $1 \
                   -n
else
    # Ubuntu16 获取证书
    sudo apt-get install -y certbot
    wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -O /etc/ipsec.d/cacerts/cacert.pem
    sudo letsencrypt certonly --standalone --agree-tos \
                   --email example@gmail.com \
                   -d $1 \
                   -n
fi


#wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -O /location