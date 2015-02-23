#!/bin/bash

#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:23
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

# Este capitulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

cp $SOURCE_DIR/misc/init.d/fedora/core5/zabbix_server /etc/init.d/zabbix_proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix_proxy
chkconfig --add zabbix_proxy
chkconfig --level 35 zabbix_proxy on
