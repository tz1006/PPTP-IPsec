# Ubuntu 脚本 #
初始化脚本  
`curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/init.sh | bash` 
* update
* rc启动脚本
* 防火墙
* ipv4 forward
* git ！
* screen ！
* python3 ！
* vnc ！


## Nginx ##
Nginx 反向代理   
`curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/nginx.sh | bash -s $(hostname) proxy.com` 

Let's Encrypt 证书   
`curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/letsencrypt.sh | bash -s $(hostname)` 

## Ikev2 For Ubuntu16/18 ##
*账号密码密钥默认都为vpn*
### 安装方法 ###
IKEv2 Ubuntu16/18  
`curl -s https://raw.githubusercontent.com/tz1006/PPTP-IPsec/master/IKEv2_ubuntu.sh | bash`  

### IPsec默认设置 ###
配置目录
`/etc/ipsec.conf`
`/etc/strongswan.d`
账号密码目录  
`/etc/ipsec.secrets`
### 证书目录 ###
### 开启端口 ###
80
500
4500
1700
1723
eth0  
### 其他信息 ###
`/etc/sysctl.conf`
`/etc/ppp/chap-secrets`

