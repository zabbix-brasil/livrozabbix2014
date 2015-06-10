#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 24-fev-2015, 10:00
#-------------------------------------------------------

CMDLINE=$0

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

# Detecta se eh um usuario com poderes de root que esta executando o script
MYUID=$(id | cut -d= -f2 | cut -d\( -f1)
if [ ! "$MYUID" -eq 0 ] ; then
        echo "voce deve ser root para executar este script."
        echo "execute o comando \"sudo $CMDLINE\""
        exit 1
fi

## Verificando se foi passado algum parametro
if [ "$#" == "0" ]
then
       echo "Voce precisa informar a versao do Zabbix a ser baixada. Ex.: 2.4.3".
       echo "O script seria chamado assim: sudo $0 2.4.3"	
       exit 1
fi

# Este capiulo utiliza como ambiente o zabbix 2.*
LINUXDISTRO=$(get_linux_distro)
VERSAO=$1;
DIR_INSTALL=/install
DIR_FONTES=$DIR_INSTALL/zabbix-$VERSAO
WGET=/usr/bin/wget

echo "Criando o diretorio $DIR_INSTALL"
mkdir $DIR_INSTALL > /dev/null 2>&1
cd $DIR_INSTALL > /dev/null

if [ ! -e $WGET ]; then 
	echo "Instalando o comando wget a ser usado para baixar os fontes do Zabbix. Aguarde..."
	case "$LINUXDISTRO" in
        	CENTOS|REDHAT)
                	yum -y install wget
	        ;;
        	DEBIAN|UBUNTU)
                	apt-get update 
			apt-get -y install wget
        	;;
	esac
fi

echo "Obtendo os arquivos fontes do Zabbix $VERSAO ." 
wget "http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$VERSAO/zabbix-$VERSAO.tar.gz"

echo "Descompactando os arquivos fontes do Zabbix em $DIR_INSTALL ." 
tar -xzvf "zabbix-$VERSAO.tar.gz" > /dev/null

echo "Os fontes do Zabbix estao no diretorio $DIR_FONTES ."
