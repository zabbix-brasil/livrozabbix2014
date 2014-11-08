echo "host_trapper backup.inicio $(date)" > /tmp/logBackup.trap
#tar -czvf /tmp/backupDados.tgz /var/www /usr/local/etc/zabbix*
TAMANHO=`du /tmp/backupDados.tgz | awk '{print $1}'`;
echo "host_trapper backup.tamanho $TAMANHO" >> /tmp/logBackup.trap
echo "host_trapper backup.fim $(date)" >> /tmp/logBackup.trap
zabbix_sender -z127.0.0.1 -i /tmp/logBackup.trap
