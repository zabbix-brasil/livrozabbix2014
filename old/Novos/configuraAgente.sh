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

SOURCE_DIR="/install/zabbix-2.*/";

# Backup do arquivo original do agente, importante guarda-lo para referencias
mv /usr/local/etc/zabbix_agentd.conf /usr/local/etc/zabbix_agentd.conf.ori

# Criando um arquivo de configuração do agente minimizado
cd $SOURCE_DIR
echo "Server=127.0.0.1" > /usr/local/etc/zabbix_agentd.conf
echo "StartAgents=3" >> /usr/local/etc/zabbix_agentd.conf
echo "DebugLevel=3" >> /usr/local/etc/zabbix_agentd.conf
echo "Hostname=$(hostname)" >> /usr/local/etc/zabbix_agentd.conf
echo "PidFile=/tmp/zabbix_agentd.pid" >> /usr/local/etc/zabbix_agentd.conf
echo "LogFile=/tmp/zabbix_agentd.log" >> /usr/local/etc/zabbix_agentd.conf
echo "Timeout=3" >> /usr/local/etc/zabbix_agentd.conf
echo "EnableRemoteCommands=1" >> /usr/local/etc/zabbix_agentd.conf

