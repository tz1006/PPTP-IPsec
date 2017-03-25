#!/bash/sh
yum -y install git wget
git clone https://github.com/tz1006/PPTP-IPsec.git ~/PPTP-IPsec

# Install PPTP
yum install -y pptpd
\cp -f ~/PPTP-IPsec/options.pptpd /etc/ppp/options.pptpd
\cp -f ~/PPTP-IPsec/chap-secrets /etc/ppp/chap-secrets
\cp -f ~/PPTP-IPsec/pptpd.conf /etc/pptpd.conf

# Install IPsec
yum -y install strongswan
# rm -rf /etc/strongswan/ipsec.conf /etc/strongswan/ipsec.secrets /etc/strongswan/strongswan.conf
\cp -f ~/PPTP-IPsec/ipsec.conf /etc/strongswan/ipsec.conf
\cp -f ~/PPTP-IPsec/ipsec.secrets /etc/strongswan/ipsec.secrets
\cp -f ~/PPTP-IPsec/strongswan.conf /etc/strongswan/strongswan.conf

# Systerm Configration
bash ~/PPTP-IPsec/sysctl.sh
bash ~/PPTP-IPsec/iptables.sh
service pptpd start
chkconfig pptpd on
service strongswan start
chkconfig strongswan on
