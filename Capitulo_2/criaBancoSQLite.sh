#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:20
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 24-fev-2015, 10:00
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

# Este capitulo utiliza como ambiente o zabbix 2.*
DIR_DB_SQLITE=/var/lib/sqlite/
DB_SQLITE=$DIR_DB_SQLITE/zabbix.db
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

cd database/sqlite3
# Cria o banco Sqlite a ser usado pelo Zabbix Proxy
mkdir -p $DIR_DB_SQLITE > /dev/null 2>&1
sqlite3 $DB_SQLITE < schema.sql; 
sqlite3 $DB_SQLITE < images.sql; 
sqlite3 $DB_SQLITE < data.sql;

# Configurando a permissao de acesso ao banco de dados
useradd zabbix -s /sbin/nologin > /dev/null 2>&1
chown -R zabbix:zabbix $DIR_DB_SQLITE

echo "O banco de dados a ser usado pelo Zabbix Proxy esta em $DB_SQLITE ."
