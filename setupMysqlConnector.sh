#!/bin/bash

HEADER_PATH=/usr/include
LIB_PATH=/usr/local/lib
TAR_PATH=`find ~/ -name mysql-connector-c++*.tar.gz -type f`
MYSQL_CONF=mysql.conf

dir_length=${#TAR_PATH}
echo $dir_length

if [  $dir_length -lt 1 ]; then
	echo "setup failed mysql-connector"
	exit
fi


echo $TAR_PATH
tar -zxvf $TAR_PATH
PWD=`pwd`
TMP_PATH=`ls | grep -v tar | egrep mysql-connector-c++`
DIR_PATH=$PWD/$TMP_PATH

cp -R $DIR_PATH/include/* /usr/include
ln -s $DIR_PATH/lib/libmysqlcppconn.so $LIB_PATH/libmysqlcppconn.so
ln -s $DIR_PATH/lib/libmysqlcppconn.so.7 $LIB_PATH/libmysqlcppconn.so.7 

echo $LIB_PATH > /etc/ld.so.conf.d/$MYSQL_CONF

ldconfig

rm -rf $DIR_PATH
