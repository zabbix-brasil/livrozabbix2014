SOURCE_DIR="/install/zabbix-2.2.2/";

# Backup do arquivo original do agente, importante guarda-lo para referencias
mv /usr/local/etc/zabbix_agentd.conf /usr/local/etc/zabbix_agentd.conf.ori

# Criando um arquivo de configuração do agente minimizado
cd $SOURCE_DIR
echo "Server=127.0.0.1" > /usr/local/etc/zabbix_agentd.conf
echo "StartAgents=3" >> /usr/local/etc/zabbix_agentd.conf
echo "DebugLevel=3" >> /usr/local/etc/zabbix_agentd.conf
echo "PidFile=/tmp/zabbix_agentd.pid" >> /usr/local/etc/zabbix_agentd.conf
echo "LogFile=/tmp/zabbix_agentd.log" >> /usr/local/etc/zabbix_agentd.conf
echo "Timeout=3" >> /usr/local/etc/zabbix_agentd.conf

