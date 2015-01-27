#!/bin/bash

# Este capítulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR

./configure --enable-proxy --enable-agent --with-sqlite3 --with-net-snmp  --with-libcurl --with-libxml2
make install

