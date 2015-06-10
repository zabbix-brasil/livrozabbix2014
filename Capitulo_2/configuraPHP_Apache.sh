#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision:     Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:35
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

case "$LINUXDISTRO" in
        CENTOS|REDHAT)
		PHPFILE=/etc/php.ini
        ;;
        DEBIAN|UBUNTU)
		PHPFILE=/etc/php5/apache2/php.ini
        ;;
esac

cp $PHPFILE $PHPFILE.ori.$$
sed -i 's/max_execution_time/\;max_execution_time/g' $PHPFILE;
echo ' max_execution_time=300'>> $PHPFILE;
sed -i 's/max_input_time/\;max_input_time/g' $PHPFILE;
echo 'max_input_time=300' >> $PHPFILE;
sed -i 's/date.timezone/\;date.timezone/g' $PHPFILE;
echo ' date.timezone=America/Sao_Paulo' >> $PHPFILE;

sed -i 's/post_max_size/\;post_max_size/g' $PHPFILE;
echo ' post_max_size=16M' >> $PHPFILE;


case "$LINUXDISTRO" in
        CENTOS|REDHAT)
		service httpd restart
        ;;
        DEBIAN|UBUNTU)
		service apache2 restart
        ;;
esac

echo "O PHP foi configurado no arquivo $PHPFILE"
