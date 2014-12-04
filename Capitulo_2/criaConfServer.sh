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
