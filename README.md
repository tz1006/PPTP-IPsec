# PPTP-IPsec #
PPTP和IPsec的配置文件以及一键安装脚本 for CentOS 6 在Vltur上完美测试
*账号密码密钥默认都为vpn*
## 安装方法 ##
IKEv2  
`curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/ikev2.sh | bash` 

两行代码  
`oral -O https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/VPN.sh`  
`bash VPN.sh`
### PPTP默认设置 ###
账号密码目录  
`/etc/ppp/chap-secrets`

### IPsec默认设置 ###
账号密码目录  
`/etc/strongswan/ipsec.secrets`
### iptables默认设置 ###
iptables默认开启端口 
22
80
443
500
4500
1700
1723
eth0  
编辑修改  
`vi /etc/sysconfig/iptables`
### 其他信息 ###
连接后无法联网修改文件  
`/etc/sysctl.conf`
