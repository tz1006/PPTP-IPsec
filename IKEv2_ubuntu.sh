#!/bash/sh

# ----设定变量----
OS_VERSION=$(lsb_release -r --short)
VERSION=${OS_VERSION::2}
if [ $VERSION == '18' ]
then
   echo '18'
else
   echo '16'
fi
