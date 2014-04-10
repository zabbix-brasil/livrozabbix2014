SOURCE_DIR="/install/zabbix-2.2.3/";
cd $SOURCE_DIR
# Backup do arquivo original do servidor, importante guarda-lo para referencias
mv /usr/local/etc/zabbix_server.conf /usr/local/etc/zabbix_server.conf.ori
# Criando um arquivo de configuração do servidor minimizado
echo "DBUser=$USUARIODB" > /usr/local/etc/zabbix_server.conf
echo "DBPassword=$SENHA" >> /usr/local/etc/zabbix_server.conf
echo "DBName=$NOMEBANCO" >> /usr/local/etc/zabbix_server.conf
echo "CacheSize=32M" >> /usr/local/etc/zabbix_server.conf
echo "DebugLevel=3" >> /usr/local/etc/zabbix_server.conf
echo "PidFile=/tmp/zabbix_server.pid" >> /usr/local/etc/zabbix_server.conf
echo "LogFile=/tmp/zabbix_server.log" >> /usr/local/etc/zabbix_server.conf
echo "Timeout=3" >> /usr/local/etc/zabbix_server.conf
# Localiza onde está o fping, a localização pode variar entre distribuições
PATH_FPING=$(which fping);
echo "FpingLocation=$PATH_FPING" >> /usr/local/etc/zabbix_server.conf


echo "Copiando arquivo de inicialização"
cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d
update-rc.d -f zabbix-server defaults



#O arquivo deve ficar como o abaixo:
#DBPassword=creative2014
#DBName=zbx_db
#CacheSize=32M
#DebugLevel=3
#PidFile=/tmp/zabbix_server.pid
#LogFile=/tmp/zabbix_server.log
#Timeout=3
#FpingLocation=/usr/bin/fping
