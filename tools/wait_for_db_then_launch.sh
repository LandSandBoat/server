#!/bin/bash

while ! mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD -e "USE $XI_DB_NAME; SELECT 1 FROM zone_weather LIMIT 1"; do
    sleep 5
done
sleep 5

# Docker specific table to track DB_VER
if [[ $(mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -e "SHOW TABLES LIKE 'DB_VER'") ]]
then
    XI_DB_VER=`mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -N -B -e "SELECT ver FROM DB_VER"`
else
    mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -e "CREATE TABLE `DB_VER` (`ver` VARCHAR(40) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
    XI_DB_VER=`git rev-parse --short=4 HEAD`
fi
echo -e "\n#DB_VER: ${XI_DB_VER}" >> ../conf/version.conf

# Update database if needed
python3 tools/dbtool.py update
XI_DB_VER=`git rev-parse --short=4 HEAD`
mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -e "UPDATE DB_VER SET ver = '${XI_DB_VER}'"

# Start servers
echo "starting topaz_connect"
nohup ./topaz_connect > topaz_connect.log &
sleep 5
echo "starting topaz_game"
nohup ./topaz_game > topaz_game.log &
sleep 5
echo "starting topaz_search"
./topaz_search > topaz_search.log
