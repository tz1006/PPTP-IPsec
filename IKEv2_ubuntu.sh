#!/bash/sh

# ----设定变量----
OS_VERSION=$(lsb_release -r --short)
VERSION=${OS_VERSION::2}
# ----备用变量----
#domain=$(hostname)
#IP=$(hostname -I)
#NetCard=$(ifconfig|grep "^en"|awk '{print $1}')
#NetCard=${NetCard::-1}
#NetCard=$(ls /sys/class/net/ |grep "^en")
#CertPath="/etc/letsencrypt/live/$(hostname)/fullchain.pem"
#KeyPath="/etc/letsencrypt/live/$(hostname)/privkey.pem"
# ---------------

if [ $VERSION == '18' ]
then
   sudo apt-get install -y strongswan strongswan-pki libcharon-standard-plugins libcharon-extra-plugins
   sudo apt-get install -y certbot
else
   sudo apt-get install -y strongswan libstrongswan-standard-plugins libstrongswan-extra-plugins
   sudo apt-get install -y letsencrypt
fi

# Disable AppArmor
sudo systemctl stop apparmor
sudo systemctl disable apparmor
#sudo /etc/init.d/apparmor stop
#sudo update-rc.d -f apparmor remove

# letsencrypt
curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/letsencrypt.sh | bash -s $(hostname)

# Config Ipsec
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.conf  -O /etc/ipsec.conf
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.secrets  -O /etc/ipsec.secrets
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/charon-logging.conf  -O /etc/strongswan.d/charon-logging.conf

# Replace example.com
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.conf
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.secrets

# ufw
sudo ufw allow 500
sudo ufw allow 4500
sudo ufw allow 1701
sudo ufw allow 1723

reboot
