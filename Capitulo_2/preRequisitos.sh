ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/debian_version ]; then
    export OS="Debian";  # XXX or Ubuntu??
    export VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # TODO add code for Red Hat and CentOS here
    export OS="CentOS";
    export VER="";
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    export OS=$DISTRIB_ID
    export VER=$DISTRIB_RELEASE
else
    export OS=$(uname -s)
    export VER=$(uname -r)
fi

# Este script foi feito para zabbix 2.*
#SOURCE_DIR="/install/zabbix-2.*";
#cd /install

case $OS in
   Debian)
apt-get -y install wget;
apt-get -y install build-essential snmp libiksemel-dev vim libssh2-1-dev libssh2-1 libopenipmi-dev libsnmp-dev wget libcurl4-gnutls-dev fping libxml2 libxml2-dev curl libcurl3-gnutls libcurl3-gnutls-dev sudo;
apt-get -y install libiksemel-dev libiksemel-utils  libiksemel3;
apt-get -y install apache2 php5 libapache2-mod-php5 php5-gd php-net-socket php5-ldap php5-curl;
apt-get -y install --force-yes php5-mysql mysql-server mysql-client libmysqld-dev;
apt-get install -y --force-yes sqlite3 libsqlite3-dev php5-sqlite;     
;;
  CentOS)
     yum -y install wget
     wget http://epel.gtdinternet.com/6/i386/epel-release-6-8.noarch.rpm
     rpm -ivh epel-release-6-*.rpm  
     yum -y update
     yum -y groupinstall 'Development Tools'; 
     yum -y install zlib-devel libc-devel curl-devel automake libidn-devel openssl-devel rpm-devel;
     yum -y install net-snmp net-snmp-devel net-snmp-utils
     yum -y install OpenIPMI OpenIPMI-devel libssh2-devel make fping yum-utils net-tools vim;
     yum -y install iksemel iksemel-devel libxml2-devel libxml2;
     yum -y install php php-bcmath php-gd php-mbstring php-xml php-ldap httpd php-ldap php-curl;
     yum -y install mysql-devel mysql mysql-server php-mysql;
     yum -y install sqlite-devel sqlite;
     ;;
   *)
     echo "Distro ($OS) nao reconhecida!";
   ;;
esac

