#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
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
# Este capítulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";

case "$LINUXDISTRO" in
        DEBIAN)
		mkdir -p /var/www/livro
		cp -r $SOURCE_DIR/frontends/php/* /var/www/livro
		chown -R www-data:www-data /var/www/
	;;
	UBUNTU)
		mkdir -p /var/www/html/livro
		cp -r $SOURCE_DIR/frontends/php/* /var/www/html/livro
		chown -R www-data:www-data /var/www/
        ;;
	CENTOS|REDHAT)
		mkdir -p /var/www/html/livro
		cp -r $SOURCE_DIR/frontends/php/* /var/www/html/livro
        ;;
esac

#Adail, comentei as linhas abaixo porque ja tem script que faz isso

#cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d
#update-rc.d -f zabbix-server defaults
# agente
#cp $SOURCE_DIR/misc/init.d/debian/zabbix-agent /etc/init.d
#update-rc.d -f zabbix-agent defaults
# proxy
#cp $SOURCE_DIR/misc/init.d/debian/zabbix-server /etc/init.d/zabbix-proxy
#sed -i 's/server/proxy/g' /etc/init.d/zabbix-proxy
#update-rc.d -f zabbix-proxy defaults
