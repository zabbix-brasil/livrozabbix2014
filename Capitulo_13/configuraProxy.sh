#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    export OS="Debian";  # XXX or Ubuntu??
    export VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # TODO add code for Red Hat and CentOS here
    export OS="CentOS";
    export VER="";
#cat /etc/redhat-release
else
    export OS=$(uname -s)
    export VER=$(uname -r)
fi

# Este script foi feito para zabbix 2.*
SOURCE_DIR="/install/zabbix-2.*";
cd $SOURCE_DIR

case $OS in
   Debian|Ubuntu)
	echo "Instalando o SQLite no Debian/Ubuntu";
	apt-get install -y --force-yes sqlite3 libsqlite3-dev php5-sqlite;
	cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d/zabbix-proxy
	sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
	sed -i 's/Server/Proxy/g' /etc/init.d/zabbix-proxy
	update-rc.d -f zabbix-proxy defaults
   ;;
   CentOS)
	echo "Instalando o SQLite no CentOS";
	yum -y install  sqlite sqlite-devel 
	cp ./misc/init.d/fedora/core5/zabbix_server /etc/init.d/zabbix_proxy
	sed -i 's/server/proxy/g' /etc/init.d/zabbix_proxy
	sed -i 's/Server/Proxy/g' /etc/init.d/zabbix_proxy
	chkconfig --add zabbix_proxy
	chkconfig --level 35 zabbix_proxy on
   ;;
   *)
	echo "Distro ($OS) nao reconhecida!";
   ;;
esac

echo "Compilando o Zabbix Proxy..."
./configure --enable-proxy --enable-agent --with-sqlite3 --with-net-snmp  --with-libcurl 
make install

echo "Criando o banco de dados do SQLIte, caso nao exista..."
if [ ! -d /var/lib/sqlite/ ]; then 
  mkdir /var/lib/sqlite/ > /dev/null 2>&1
fi 
if [ ! -f /var/lib/sqlite/zabbix.db ]; then
   sqlite3 /var/lib/sqlite/zabbix.db < ./database/sqlite3/schema.sql
fi 
chown -R zabbix:zabbix /var/lib/sqlite/

CONF_PROXY=/usr/local/etc/zabbix_proxy.conf
DB_SQLITE=/var/lib/sqlite/zabbix.db

USUARIODB="zabbix";

mv $CONF_PROXY $CONF_PROXY.ori.$$
echo "DBName=$DB_SQLITE" > $CONF_PROXY
echo "DBUser=$USUARIODB" >> $CONF_PROXY
echo "ConfigFrequency=120" >> $CONF_PROXY

echo "DebugLevel=3" >> $CONF_PROXY
echo "Hostname=proxy_filial" >> $CONF_PROXY
echo "Server=localhost" >> $CONF_PROXY
echo "ServerPort=10051" >> $CONF_PROXY
echo "ListenPort=10053" >> $CONF_PROXY
echo "PidFile=/tmp/zabbix_proxy.pid" >> $CONF_PROXY
echo "LogFile=/tmp/zabbix_proxy.log" >> $CONF_PROXY
echo "Timeout=3" >> $CONF_PROXY

PATH_FPING=$(which fping);
echo "FpingLocation=$PATH_FPING" >> $CONF_PROXY

echo "O arquivo de configuracao do Zabbix Proxy esta em $CONF_PROXY"

