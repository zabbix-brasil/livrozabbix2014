#!/bin/bash

# Este capítulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

./configure --enable-server --enable-agent --with-mysql --with-net-snmp  --with-jabber=/usr  --with-libcurl --with-libxml2 --with-openipmi
make install

