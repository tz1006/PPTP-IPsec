#!/bash/sh

# ----设定变量----

# ---------------

# Prerequisites
sudo apt-get update -y
sudo apt-get install -y strongswan libstrongswan-standard-plugins libstrongswan-extra-plugins letsencrypt

# Disable AppArmor
sudo systemctl stop apparmor
sudo systemctl disable apparmor
#sudo /etc/init.d/apparmor stop
#sudo update-rc.d -f apparmor remove

# Apply Cert
wget https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -O /etc/ipsec.d/cacerts/cacert.pem
sudo letsencrypt certonly --standalone --agree-tos \
                   --email example@gmail.com \
                   -d $(hostname) \
                   -n

# Config Ipsec
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.conf  -O /etc/ipsec.conf
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.secrets  -O /etc/ipsec.secrets
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/charon-logging.conf  -O /etc/strongswan.d/charon-logging.conf

# Replace example.com
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.conf
sed -i "s/example.com/$(hostname)/g" /etc/ipsec.secrets
# Replace certbot
sed -i "s/certbot/letsencrypt/g" /etc/ipsec.conf
sed -i "s/certbot/letsencrypt/g" /etc/ipsec.secrets



# restart
#reboot
#sudo service pptpd start
#sudo sysv-rc-conf pptpd on
#sudo service ipsec restart
#sudo sysv-rc-conf strongswan on
