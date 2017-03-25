#!/bash/sh
yum -y install git wget
git clone https://github.com/tz1006/PPTP-IPsec.git ~/ipsec
yum -y install strongswan
# rm -rf /etc/strongswan/ipsec.conf /etc/strongswan/ipsec.secrets /etc/strongswan/strongswan.conf
\cp -f /root/ipsec/ipsec.conf /etc/strongswan/ipsec.conf
\cp -f /root/ipsec/ipsec.secrets /etc/strongswan/ipsec.secrets
\cp -f /root/ipsec/strongswan.conf /etc/strongswan/strongswan.conf
bash ~/ipsec/sysctl.sh
bash ~/ipsec/iptables.sh
service strongswan start
chkconfig strongswan on
