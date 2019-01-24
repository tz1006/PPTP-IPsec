#!/bash/sh


# ----设定变量----
domain = @1
# ---------------



# Prerequisites
sudo apt-get update -y
sudo apt-get install -y strongswan strongswan-pkl centbot
#sudo apt-get install -y sysv-rc-conf

# Apply Cert
sudo certbot certonly --standalone --agree-tos \
                   --no-eff-email \
                   --email hakase@gmail.com \
                   -d ikev2.hakase-labs.io

# Config Ipsec
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.conf -O /etc/ipsec.conf
sudo wget  -O  /etc/strongswan.d/strongswan.conf
sudo wget https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/config/ipsec.conf -O /etc/ipsec.secrets


# Sysctl Config
sudo sed -i 's/^net.ipv4.ip_forward.*/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sudo sysctl -p

# Firewall
sudo ufw allow 500
sudo ufw allow 4500
sudo ufw allow 1701
sudo ufw allow 1723

# restart
#sudo service pptpd start
#sudo sysv-rc-conf pptpd on
sudo service strongswan restart
#sudo sysv-rc-conf strongswan on
