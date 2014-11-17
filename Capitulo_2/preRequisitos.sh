# Instalacao base
apt-get -y install build-essential snmp vim libssh2-1-dev libssh2-1 libopenipmi-dev libsnmp-dev wget curl fping snmp-mibs-downloader iotop ntp


# Instalação do suporte a Jabber
apt-get -y install libiksemel-dev 

# Instalação dos requisitos para o frontend
apt-get -y install apache2 php5 libapache2-mod-php5 php5-gd php-net-socket php5-ldap 

# Instalação de MySQL
apt-get -y install php5-mysql mysql-server mysql-client libmysqld-dev 
# Instalação de SQLite
apt-get -y install php5-sqlite libsqlite3-dev sqlite3
