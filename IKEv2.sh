#!/bash/sh

# ----设定变量----
#domain=$(hostname)
#IP=$(hostname -I)
#NetCard=$(ifconfig|grep "^en"|awk '{print $1}')
#NetCard=${NetCard::-1}
#NetCard=$(ls /sys/class/net/ |grep "^en")
#CertPath="/etc/letsencrypt/live/$(hostname)/fullchain.pem"
#KeyPath="/etc/letsencrypt/live/$(hostname)/privkey.pem"
# ---------------

# Prerequisites
sudo apt-get update -y
sudo apt-get install -y strongswan strongswan-pki libcharon-standard-plugins libcharon-extra-plugins 
sudo apt-get install -y certbot
#sudo apt-get install -y sysv-rc-conf

# Disable AppArmor
sudo systemctl stop apparmor
sudo systemctl disable apparmor
#sudo /etc/init.d/apparmor stop
#sudo update-rc.d -f apparmor remove

# Apply Cert
wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -O /etc/ipsec.d/cacerts/cacert.pem
sudo certbot certonly --standalone --agree-tos \
                   --no-eff-email \
                   --email example@gmail.com \
                   -d $(hostname) \
                   -n

# Config Ipsec
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.conf  -O /etc/ipsec.conf
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.secrets  -O /etc/ipsec.secrets
#sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/charon-logging.conf  -O /etc/strongswan.d/charon-logging.conf

# Replace example.com
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.conf
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.secrets

# Sysctl Config
sed -i '/net.ipv4.ip_forward/c net.ipv4.ip_forward = 1' /etc/sysctl.conf
#sudo sysctl -p

# Firewall
#sudo iptables -X
sudo ufw allow 22
sudo ufw allow 53
sudo ufw allow 80
sudo ufw allow 500
sudo ufw allow 4500
sudo ufw allow 1701
#sudo ufw allow 1723
#iptables -t nat -A POSTROUTING -s 10.99.1.0/24 -j MASQUERADE
#iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -j MASQUERADE

# Startup Script
curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/rc.sh | bash 
sed '3a iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -j MASQUERADE' -i /etc/rc.local
sudo ufw -f disable && sudo ufw -f enable
#sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE


# restart
reboot
#sudo service pptpd start
#sudo sysv-rc-conf pptpd on
#sudo service ipsec restart
#sudo sysv-rc-conf strongswan on
