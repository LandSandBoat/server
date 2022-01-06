#!/bin/bash

while ! mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -e "SELECT 1 FROM zone_weather LIMIT 1"; do
    sleep 5
done
sleep 5

# Start servers
echo "starting xi_login"
nohup ./xi_login &
sleep 5

echo "starting xi_search"
nohup ./xi_search &

sleep 5
echo "starting xi_zone"
./xi_zone
