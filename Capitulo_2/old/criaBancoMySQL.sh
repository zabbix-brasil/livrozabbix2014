#!/bin/bash

# Este capítulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

# Para ambientes de produção modificar aqui... as senhas aqui são propositalmente fracas
SENHA="creative2014";
SENHAROOT="$SENHA_root";
NOMEBANCO="zbx_db";
USUARIODB="zbx_db";

# Redefinir a senha do root
MYADMIN=$(which mysqladmin)
$MYADMIN -u root $SENHAROOT


echo "create database $NOMEBANCO character set utf8;" | mysql -uroot -p$SENHAROOT
echo "GRANT ALL PRIVILEGES ON $NOMEBANCO.* TO $USUARIODB@localhost IDENTIFIED BY '$SENHA' WITH GRANT OPTION;" | mysql -uroot -p$SENHAROOT

# Senha padrao $SENHA
cat database/mysql/schema.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/images.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/data.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO;

