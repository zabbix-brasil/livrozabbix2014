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

## Verificando se foi passado algum parametro
if [ "$#" == "0" ]
then
       echo "Voce precisa informar a versao do Zabbix a ser baixada. Ex.: 2.4.3".
       echo "O script seria chamado assim: sudo $0 2.4.3"	
       exit 1
fi

# Este capítulo utiliza como ambiente o zabbix 2.*
mkdir /install
cd /install

VERSAO=$1;
wget "http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$VERSAO/zabbix-$VERSAO.tar.gz"
tar -xzvf "zabbix-$VERSAO.tar.gz"

echo "Os fontes do Zabbix estao em /install/zabbix-$VERSAO.tar.gz"
