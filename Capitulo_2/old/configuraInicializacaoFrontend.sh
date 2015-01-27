# server
cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d
update-rc.d -f zabbix-server defaults

# agente
cp $SOURCE_DIR/misc/init.d/debian/zabbix-agent /etc/init.d
update-rc.d -f zabbix-agent defaults
# proxy
cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d/zabbix-proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
update-rc.d -f zabbix-proxy defaults

cp -r $SOURCE_DIR/frontends/php/* /var/www/
chown -R www-data:www-data /var/www/

