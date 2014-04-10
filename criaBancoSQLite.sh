
# Este capítulo utiliza como ambiente o zabbix 2.2.3
SOURCE_DIR="/install/zabbix-2.2.3";
cd $SOURCE_DIR

cd database/sqlite3
# Cria localização do repositorio de dados
mkdir /var/lib/sqlite/
sqlite3 /var/lib/sqlite/zabbix.db < schema.sql; 
sqlite3 /var/lib/sqlite/zabbix.db < images.sql; 
sqlite3 /var/lib/sqlite/zabbix.db < data.sql;

# Configurando a permissao do arquivo
useradd zabbix
chown -R zabbix:zabbix /var/lib/sqlite/
