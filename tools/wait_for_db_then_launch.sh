#!/bin/bash

while ! mysql --host=$XI_DB_HOST --port=$XI_DB_PORT --user=$XI_DB_USER --password=$XI_DB_USER_PASSWD $XI_DB_NAME -e "SELECT 1 FROM zone_weather LIMIT 1"; do
    sleep 5
done
sleep 5

# Start servers
echo "starting topaz_connect"
nohup ./topaz_connect &
sleep 5

echo "starting topaz_search"
nohup ./topaz_search &

sleep 5
echo "starting topaz_game"
./topaz_game
