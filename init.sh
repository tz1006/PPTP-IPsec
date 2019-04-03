#!/bash/sh

sudo apt update -y

# 启动脚本rc
curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/rc.sh | bash 
sed '3a iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -j MASQUERADE' -i /etc/rc.local

# 防火墙
# sysctl
sed -i '/net.ipv4.ip_forward/c net.ipv4.ip_forward = 1' /etc/sysctl.conf
sudo sysctl -p

sudo iptables -X
sudo ufw allow 22
sudo ufw allow 53
#sudo ufw allow 80
#sudo ufw allow 500
#sudo ufw allow 4500
#sudo ufw allow 1701
#sudo ufw allow 1723
#iptables -t nat -A POSTROUTING -s 10.99.1.0/24 -j MASQUERADE
#iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -j MASQUERADE

sudo ufw -f disable && sudo ufw -f enable
#sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
