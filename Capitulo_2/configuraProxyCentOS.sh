
# Este capítulo utiliza como ambiente o zabbix 2.2.3
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

cp $SOURCE_DIR/misc/init.d/fedora/core5/zabbix-server /etc/init.d/zabbix-proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
chkconfig --add zabbix_proxy
chkconfig --level 35 zabbix_proxy on
