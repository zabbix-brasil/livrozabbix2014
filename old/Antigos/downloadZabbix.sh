mkdir /install
cd /install

VERSAO="2.2.2"
wget -O zabbix.tgz http://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$VERSAO/zabbix-$VERSAO.tar.gz?r=http%3A%2F%2Fwww.zabbix.com%2Fdownload.php&ts=1346344892&use_mirror=ufpr 

tar -xzvf zabbix.tgz