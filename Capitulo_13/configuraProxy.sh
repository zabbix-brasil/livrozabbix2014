ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    export OS="Debian";  # XXX or Ubuntu??
    export VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # TODO add code for Red Hat and CentOS here
    export OS="CentOS";
    export VER="";
#cat /etc/redhat-release
else
    export OS=$(uname -s)
    export VER=$(uname -r)
fi

# Este script foi feito para zabbix 2.*
SOURCE_DIR="/install/zabbix-2.*";
cd $SOURCE_DIR

case $OS in
   Debian)
     echo "Instalando em debian";
     apt-get install -y --force-yes sqlite3 libsqlite3-dev php5-sqlite;
cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d/zabbix-proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
sed -i 's/Server/Proxy/g' /etc/init.d/zabbix-proxy
update-rc.d -f zabbix-proxy defaults
   ;;
   CentOS)
     echo "Instalando em CentOS";
     yum -y install  sqlite sqlite-devel 
cp ./misc/init.d/fedora/core5/zabbix_server /etc/init.d/zabbix_proxy
sed -i 's/server/proxy/g' /etc/init.d/zabbix_proxy
sed -i 's/Server/Proxy/g' /etc/init.d/zabbix_proxy
chkconfig --add zabbix_proxy
chkconfig --level 35 zabbix_proxy on
   ;;
   *)
     echo "Distro ($OS) nao reconhecida!";
   ;;
esac
./configure --enable-proxy --enable-agent --with-sqlite3 --with-net-snmp  --with-libcurl 
make install
if [ ! -d /var/lib/sqlite/ ]; then 
  mkdir /var/lib/sqlite/
fi 
if [ ! -f /var/lib/sqlite/zabbix.db ]; then
   sqlite3 /var/lib/sqlite/zabbix.db < ./database/sqlite3/schema.sql
fi 
chown -R zabbix:zabbix /var/lib/sqlite/
