# #!/bin/sh

sudo ln -fs /lib/systemd/system/rc-local.service /etc/systemd/system/rc-local.service  

sudo echo '#!/bin/sh -e
# 
# rc.local

exit 0' > /etc/rc.local

sudo chmod 755 /etc/rc.local 