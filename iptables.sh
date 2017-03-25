# iptables
# vi /etc/sysconfig/iptables

iptables -F
iptables -X
/sbin/iptables -I INPUT -i eth0 -p esp -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 1723 -j ACCEPT
/sbin/iptables -I INPUT -p udp --dport 1701 -j ACCEPT
/sbin/iptables -I INPUT -p udp --dport 4500 -j ACCEPT
/sbin/iptables -I INPUT -p udp --dport 500 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 443 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth0 -s 192.168.80.0/24 -j MASQUERADE
/etc/rc.d/init.d/iptables save
service iptables restart
