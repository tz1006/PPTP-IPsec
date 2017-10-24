#!/bash/sh
sudo apt-get update -y
sudo apt-get install -y sysv-rc-conf
git https://github.com/tz1006/PPTP-IPsec.git

# Install PPTP
sudo apt-get install -y pptpd
sudo cp -f ~/PPTP-IPsec/options.pptpd /etc/ppp/options.pptpd
sudo cp -f ~/PPTP-IPsec/chap-secrets /etc/ppp/chap-secrets
sudo cp -f ~/PPTP-IPsec/pptpd.conf /etc/pptpd.conf

# Install IPsec
sudo apt-get install -y strongswan
sudo cp -f ~/PPTP-IPsec/ipsec.conf /etc/ipsec.conf
sudo cp -f ~/PPTP-IPsec/ipsec.secrets /etc/ipsec.secrets
sudo cp -f ~/PPTP-IPsec/strongswan.conf /etc/strongswan.conf

# Sysctl Config
sudo sed -i 's/^net.ipv4.ip_forward.*/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
sudo sysctl -p

# Firewall
sudo ufw allow 500
sudo ufw allow 4500
sudo ufw allow 4500
sudo ufw allow 1701
sudo ufw allow 1723

# Start
sudo service pptpd start
sudo sysv-rc-conf pptpd on
sudo service strongswan start
sudo sysv-rc-conf strongswan on
