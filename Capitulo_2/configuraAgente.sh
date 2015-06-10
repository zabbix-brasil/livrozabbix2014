#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
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

SOURCE_DIR="/install/zabbix-2.*/";
CONF_AGENTE=/usr/local/etc/zabbix_agentd.conf

# Backup do arquivo original do agente, importante guarda-lo para referencias
mv $CONF_AGENTE $CONF_AGENTE.ori.$$

# Criando um arquivo de configuração do agente minimizado
cd $SOURCE_DIR
echo "Server=127.0.0.1" > $CONF_AGENTE
echo "StartAgents=3" >> $CONF_AGENTE
echo "DebugLevel=3" >> $CONF_AGENTE
echo "Hostname=$(hostname)" >> $CONF_AGENTE
echo "PidFile=/tmp/zabbix_agentd.pid" >> $CONF_AGENTE
echo "LogFile=/tmp/zabbix_agentd.log" >> $CONF_AGENTE
echo "Timeout=3" >> $CONF_AGENTE
echo "EnableRemoteCommands=1" >> $CONF_AGENTE

echo "O arquivo de configuracao do Zabbix Agentd esta em $CONF_AGENTE"

