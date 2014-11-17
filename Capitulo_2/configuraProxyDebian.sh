
# Este capítulo utiliza como ambiente o zabbix 2.2.3
SOURCE_DIR="/install/zabbix-2.2.3";
cd $SOURCE_DIR

cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d/zabbix-proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
update-rc.d -f zabbix-proxy defaults
