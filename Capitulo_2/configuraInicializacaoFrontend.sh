#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:32
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

LINUXDISTRO=$(get_linux_distro)
# Este capitulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";

case "$LINUXDISTRO" in
        DEBIAN)
        	ZABBIX_WEB_DIR=/var/www/livro
		mkdir -p $ZABBIX_WEB_DIR > /dev/null 2>&1
		cp -r $SOURCE_DIR/frontends/php/* $ZABBIX_WEB_DIR
		chown -R www-data:www-data /var/www/
	;;
	UBUNTU)
		ZABBIX_WEB_DIR=/var/www/html/livro
		mkdir -p $ZABBIX_WEB_DIR > /dev/null 2>&1
		cp -r $SOURCE_DIR/frontends/php/* $ZABBIX_WEB_DIR
		chown -R www-data:www-data /var/www/
        ;;
	CENTOS|REDHAT)
		ZABBIX_WEB_DIR=/var/www/html/livro
		mkdir -p $ZABBIX_WEB_DIR > /dev/null 2>&1
		cp -r $SOURCE_DIR/frontends/php/* $ZABBIX_WEB_DIR
		chown -R apache:apache /var/www/html/livro
        ;;
esac

echo "A interface web do Zabbix foi instalada em $ZABBIX_WEB_DIR"

