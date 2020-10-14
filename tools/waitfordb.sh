#!/bin/bash

while ! mysql --host=$TPZ_DB_HOST --port=$TPZ_DB_PORT --user=$TPZ_DB_USER --password=$TPZ_DB_USER_PASSWD -e "USE $TPZ_DB_NAME; SELECT 1 FROM zone_weather LIMIT 1"; do
    sleep 5
done
