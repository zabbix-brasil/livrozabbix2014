#! /bin/bash
#
# Name: zalld
#
# Custom LLD SAmple.
#
# Author: Adail Horst
#
# Version: 1.0
#
 
zaver="1.0";
rval=0;
CAMINHO_FRONTEND="http://localhost/livro/livro-extras";

usage() {
    echo "zalld version: $zaver $#"
    echo "Parametros:";
    echo "    LLD -- Retorna a lista de tabelas.";
    echo "    count <TABELA> -- retorna a quantidade de linhas de uma tabela.";
    echo "    version -- retorna a versao do script";
}

########
# Main #
########
#set -x
OPCAO=$1;
case $OPCAO in
'LLD')
#    curl "$CAMINHO_FRONTEND/lldBasesMySQL.php?p_acao=LLD" 2>/dev/null;
     curl "$CAMINHO_FRONTEND/lldBasesMySQL.php?p_acao=LLD" ;
;;
'count')
    curl "$CAMINHO_FRONTEND/lldBasesMySQL.php?p_acao=count&p_tabela=$2"  ;
#    curl "$CAMINHO_FRONTEND/lldBasesMySQL.php?p_acao=count&p_tabela=$2" 2>/dev/null ;
;;
'version')
    echo $zaver;
;;
*)
    usage
    exit $rval;;
esac


exit $rval

#
# end
