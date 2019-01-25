#!/bash/sh

# ----设定变量----
OS_VERSION=$(lsb_release -r --short)
VERSION=${OS_VERSION::2}
if [ $VERSION == '18' ]
then
   bash
else
   bash
fi
