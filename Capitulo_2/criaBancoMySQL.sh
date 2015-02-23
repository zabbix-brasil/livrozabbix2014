#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision: 	Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:13
#-------------------------------------------------------

CMDLINE=$0

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

#-----------------------------------------------------------
# comment: Obtem o nome da distribuicao
# syntax: LINUXDISTRO=$(get_linux_distro)
# return: $LINUXDISTRO contem o nome da distro
#
get_linux_distro(){
LINUXDISTRO=UNKNOWN

# Obtendo o codnome da distro
grep "Debian" /etc/issue > /dev/null 2>&1 && LINUXDISTRO=DEBIAN
grep "CentOS" /etc/redhat-release > /dev/null 2>&1 && LINUXDISTRO=CENTOS
grep "Red Hat" /etc/redhat-release > /dev/null 2>&1 && LINUXDISTRO=REDHAT
grep "Ubuntu" /etc/issue > /dev/null 2>&1 && LINUXDISTRO=UBUNTU

echo $LINUXDISTRO
}

# Este capítulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

# Para ambientes de produção modificar aqui... as senhas aqui são propositalmente fracas
SENHA="creative2014";
SENHAROOT="creative2014_root";
NOMEBANCO="zbx_db";
USUARIODB="zbx_db";

# Iniciando o MySQL
LINUXDISTRO=$(get_linux_distro)

case "$LINUXDISTRO" in
        CENTOS|REDHAT)
		service mysqld start
        ;;
esac

# Redefinir a senha do root
LINUXDISTRO=$(get_linux_distro)

case "$LINUXDISTRO" in
        CENTOS|REDHAT)
		MYADMIN=$(which mysqladmin)
		$MYADMIN -u root password $SENHAROOT
        ;;
esac

echo "create database $NOMEBANCO character set utf8;" | mysql -uroot -p$SENHAROOT
echo "GRANT ALL PRIVILEGES ON $NOMEBANCO.* TO $USUARIODB@localhost IDENTIFIED BY '$SENHA' WITH GRANT OPTION;" | mysql -uroot -p$SENHAROOT

# Senha padrao $SENHA
cat database/mysql/schema.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/images.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/data.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO;

