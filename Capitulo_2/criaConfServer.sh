#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:37
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi


# Para ambientes de produção modificar aqui... as senhas aqui são propositalme fracas
# Caso voce tenha modificado as senhas, pode ajustar as variaveia abaixo
SENHA="creative2014";
SENHAROOT="creative2014_root";
NOMEBANCO="zbx_db";
USUARIODB="zbx_db";

mv /usr/local/etc/zabbix_server.conf /usr/local/etc/zabbix_server.conf.ori
echo "DBUser=$USUARIODB" > /usr/local/etc/zabbix_server.conf
echo "DBPassword=$SENHA" >> /usr/local/etc/zabbix_server.conf
echo "DBName=$NOMEBANCO" >> /usr/local/etc/zabbix_server.conf
echo "CacheSize=32M" >> /usr/local/etc/zabbix_server.conf

echo "DebugLevel=3" >> /usr/local/etc/zabbix_server.conf
echo "PidFile=/tmp/zabbix_server.pid" >> /usr/local/etc/zabbix_server.conf
echo "LogFile=/tmp/zabbix_server.log" >> /usr/local/etc/zabbix_server.conf
echo "Timeout=3" >> /usr/local/etc/zabbix_server.conf

PATH_FPING=$(which fping);
echo "FpingLocation=$PATH_FPING" >> /usr/local/etc/zabbix_server.conf
