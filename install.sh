#!/bin/bash

# Remote Usage:

if [ -f /etc/os-release ]
then
    . /etc/os-release
    OS=$ID
    OS_LIKE=$ID_LIKE
fi
DEBIAN="^debian|[[:space:]]debian|^ubuntu|[[:space:]]ubuntu"
ARCH="^arch|[[:space:]]arch"
# Use your package manager to install the following packages or their equivalent:
if [ $OS = "debian" ] || [[ $OS_LIKE =~ $DEBIAN ]]
then
    sudo apt update || exit
    sudo apt install git python3 python3-pip g++-9 cmake make libluajit-5.1-dev libzmq3-dev libssl-dev zlib1g-dev mariadb-server libmariadb-dev || exit
elif [ $OS = "arch" ] || [[ $OS_LIKE =~ $ARCH ]]
then
    sudo pacman -S git python3 python-pip gcc cmake make luajit zeromq openssl zlib || exit
    type mysql >/dev/null 2>&1 && INSTALL_MYSQL=0 || INSTALL_MYSQL=1
    if [ $INSTALL_MYSQL -eq 1 ]
    then
        sudo pacman -S mariadb || exit
        # Arch users will need to initialize and start the database software if not done already:
        sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
        sudo systemctl enable mariadb
        sudo systemctl start mariadb
    fi
else
    echo "Sorry, this OS is unsupported at this time." && exit
fi
# Download the latest code, install Python requirements, and copy the configuration files:
if [ ! -e install.sh ]
then
    git clone --recursive https://github.com/DerpyProjectGroup/topaz.git
    cd topaz
fi
pip3 install -r tools/requirements.txt
cp conf/default/* conf/
clear
# Run the following script to improve database security:
sudo mysql_secure_installation
# Change these to improve security:
echo -e "\nCreate a Topaz MySQL user. (default: topaz)"
echo "WARNING! This user will be dropped if it exists. Leave blank for default."
read -r -p "Login: " XI_LOGIN
if [ -z "$XI_LOGIN" ]
then
    XI_LOGIN="topaz"
fi
read -r -p "Password: " XI_PASSWORD
if [ -z "$XI_PASSWORD" ]
then
    XI_PASSWORD="password"
fi
echo "Name your database. (default: xidb)"
echo "WARNING! This database will be reset to default if it exists. Leave blank for default."
read -r -p "Name: " XI_DB
if [ -z "$XI_DB" ]
then
    XI_DB="xidb"
fi
# Create a database user and empty database with the login, password, and database name provided:
echo -e "\nEnter the MySQL root password."
DB_QUERY="DROP USER IF EXISTS '$XI_LOGIN'@'localhost'; \
    CREATE USER '$XI_LOGIN'@'localhost' IDENTIFIED BY '$XI_PASSWORD'; \
    CREATE DATABASE IF NOT EXISTS $XI_DB;USE $XI_DB; \
    GRANT ALL PRIVILEGES ON $XI_DB.* TO '$XI_LOGIN'@'localhost';"
sudo mysql -u root -p -e "$DB_QUERY" || exit
# Edit the new login.conf, map.conf, and search_server.conf files in topaz/conf/ and change MySQL info
sed -i "s/mysql_login:     root/mysql_login:     "$XI_LOGIN"/g" conf/map.conf
sed -i "s/mysql_login:     root/mysql_login:     "$XI_LOGIN"/g" conf/login.conf
sed -i "s/mysql_login:     root/mysql_login:     "$XI_LOGIN"/g" conf/search_server.conf
sed -i "s/mysql_password:  root/mysql_password:  "$XI_PASSWORD"/g" conf/map.conf
sed -i "s/mysql_password:  root/mysql_password:  "$XI_PASSWORD"/g" conf/login.conf
sed -i "s/mysql_password:  root/mysql_password:  "$XI_PASSWORD"/g" conf/search_server.conf
sed -i "s/mysql_database:  xidb/mysql_database:  "$XI_DB"/g" conf/map.conf
sed -i "s/mysql_database:  xidb/mysql_database:  "$XI_DB"/g" conf/login.conf
sed -i "s/mysql_database:  xidb/mysql_database:  "$XI_DB"/g" conf/search_server.conf
# Build the database:
cd sql
for SQL_FILE in *.sql
    do
        echo "Importing $SQL_FILE..."
        mysql -u $XI_LOGIN -p$XI_PASSWORD $XI_DB < "$SQL_FILE"
    done
DB_VER=`git rev-parse --short=4 HEAD`
echo -e "\n#DB_VER: $DB_VER" >> ../conf/version.conf
echo "Finished importing!"
# Prepare and build the executables:
if [ ! -d ../build ]
then
    mkdir ../build
fi
cd ../build
cmake ..
make -j $(nproc)
# Set zoneip
IP=`mysql -u $XI_LOGIN -p$XI_PASSWORD $XI_DB -N -e "SELECT zoneip FROM zone_settings LIMIT 1;"`
echo -e "\nCurrent zoneip: $IP"
echo && read -r -p "Would you like to change the server IP? [y/N] " ZONEIP
if [ ! -z "$ZONEIP" ] && [[ "$ZONEIP" =~ ^[Yy]$ ]]
then
    IP=`curl -s https://ipinfo.io/ip || echo 0`
    echo -e "\nAvailable IPv4 addresses:"
    ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
    if [ $IP != 0 ]
    then
        echo "$IP *WAN"
    fi
    echo && read -r -p "Enter zoneip (leave empty to keep current): " IP
    if [ ! -z "$IP" ]
    then
        mysql -u $XI_LOGIN -p$XI_PASSWORD $XI_DB -e "UPDATE zone_settings SET zoneip = '$IP';" || exit
        echo "Set zoneip to '$IP'!"
    else
        echo "Set zoneid skipped."
    fi
fi
echo "Installation complete!"
