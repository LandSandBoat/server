#!/bin/bash

while ! mysql --host=$XI_NETWORK_SQL_HOST --port=$XI_NETWORK_SQL_PORT --user=$XI_NETWORK_SQL_LOGIN --password=$XI_NETWORK_SQL_PASSWORD $XI_NETWORK_SQL_DATABASE -e "SELECT 1 FROM zone_weather LIMIT 1"; do
    sleep 5
done
sleep 5

# Start servers
echo "starting xi_connect"
nohup ./xi_connect &
sleep 5

echo "starting xi_search"
nohup ./xi_search &

sleep 5
echo "starting xi_map"
./xi_map
