#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:37
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

CONF_SERVER=/usr/local/etc/zabbix_server.conf
# Para ambientes de producao modificar aqui... as senhas aqui sao propositalmente fracas
# Caso voce tenha modificado as senhas, pode ajustar as variaveis abaixo
SENHA="creative2014";
SENHAROOT="creative2014_root";
NOMEBANCO="zbx_db";
USUARIODB="zbx_db";

mv $CONF_SERVER $CONF_SERVER.ori.$$
echo "DBUser=$USUARIODB" > $CONF_SERVER
echo "DBPassword=$SENHA" >> $CONF_SERVER
echo "DBName=$NOMEBANCO" >> $CONF_SERVER
echo "CacheSize=32M" >> $CONF_SERVER

echo "DebugLevel=3" >> $CONF_SERVER
echo "PidFile=/tmp/zabbix_server.pid" >> $CONF_SERVER
echo "LogFile=/tmp/zabbix_server.log" >> $CONF_SERVER
echo "Timeout=3" >> $CONF_SERVER

PATH_FPING=$(which fping);
echo "FpingLocation=$PATH_FPING" >> $CONF_SERVER

echo "O arquivo de configuracao do Zabbix Server esta em $CONF_SERVER"
