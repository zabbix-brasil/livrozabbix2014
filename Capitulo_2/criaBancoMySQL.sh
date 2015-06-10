#!/bin/bash
#-------------------------------------------------------
# author:       Adail Spinola <the.spaww@gmail.com>, Aecio Pires <aeciopires@gmail.com> e Andre Deo <andredeo@gmail.com>
# date:         20-nov-2014
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 21-jan-2015, 18:08
# revision: 	Andre Deo <andredeo@gmail.com>
# Last updated: 27-jan-2015, 23:13
# revision:     Aecio Pires <aecio@dynavideo.com.br>
# Last updated: 24-fev-2015, 10:00
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

# Este capitulo utiliza como ambiente o zabbix 2.*
SOURCE_DIR="/install/zabbix-2*";
cd $SOURCE_DIR
LINUXDISTRO=$(get_linux_distro)

# Para ambientes de producao modificar aqui... as senhas aqui sao propositalmente fracas
SENHA="creative2014";
SENHAROOT="creative2014_root";
NOMEBANCO="zbx_db";
USUARIODB="zbx_db";

case "$LINUXDISTRO" in
        CENTOS|REDHAT)
		echo "Iniciando o MySQL..."
		service mysqld start
		
		echo "Redefina a senha do root do MySQL"
		MYADMIN=$(which mysqladmin)
		$MYADMIN -u root password $SENHAROOT
        ;;
esac

echo "Criando o usuario a ser usado pelo Zabbix para acessar o banco de dados no MySQL..."
echo "create database $NOMEBANCO character set utf8;" | mysql -uroot -p$SENHAROOT
echo "GRANT ALL PRIVILEGES ON $NOMEBANCO.* TO $USUARIODB@localhost IDENTIFIED BY '$SENHA' WITH GRANT OPTION;" | mysql -uroot -p$SENHAROOT

echo "Populando o banco de dados do Zabbix no MySQL..."
cat database/mysql/schema.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/images.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO; 
cat database/mysql/data.sql | mysql -u $USUARIODB -p$SENHA $NOMEBANCO;

echo "As informacoes usadas para criar o banco de dados foram..."
echo "SENHA_ROOT_MYSQL=$SENHAROOT"
echo "NOME_USUARIO_DB=$USUARIODB"
echo "SENHA=$SENHA"
echo "NOME_BANCO=$NOMEBANCO"

echo "Para ambientes de producao modifique estes dados no script... as senhas usadas aqui sao propositalmente fracas."


