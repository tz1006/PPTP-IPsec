#!/bash/sh

# ----设定变量----
OS_VERSION=$(lsb_release -r --short)
VERSION=${OS_VERSION::2}

if [ $VERSION == '18' ]
then
   curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/IKEv2.sh | bash
else
   curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/IKEv2_ubuntu16.sh | bash
fi

sudo ufw allow 500
sudo ufw allow 4500
sudo ufw allow 1701
sudo ufw allow 1723

reboot
