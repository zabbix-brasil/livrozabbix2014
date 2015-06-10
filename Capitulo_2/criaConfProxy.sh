#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 24-fev-2015, 10:00
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

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
