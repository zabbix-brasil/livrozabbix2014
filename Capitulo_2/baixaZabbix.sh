#!/bin/bash

# Este capítulo utiliza como ambiente o zabbix 2.*
cd /install

VERSAO=$1;
wget "http://ufpr.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/$VERSAO/zabbix-$VERSAO.tar.gz"
tar -xzvf "zabbix-$VERSAO.tar.gz"

