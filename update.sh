#!/bin/bash

REMOTE="origin" # Remote to pull from
SERVICE="" # Systemd service (e.g. "topaz.service")

stash() {
    git status --porcelain | grep "^." >/dev/null
    if [ $? -eq 0 ]
    then
        if git stash push -m "Auto stash for update on `date`"
        then
            stash=1
        fi
    fi
}
unstash() {
    if [ $stash -eq 1 ]
    then
        git stash pop
    fi
}

# Stash any changes you've made and pull the latest code from upstream:
if [ ! -z "$SERVICE" ]
then
    sudo systemctl stop $SERVICE
fi
stash=0
stash
git pull $REMOTE --ff-only || { unstash && exit; }
unstash
# If you stashed any changes, there is a chance you need to manually edit any conflicting files before continuing.
test=`git diff --check`
if [ -z "$test" ]
then
    # Prepare and build the executables:
    if [ ! -d build ]
    then
        mkdir build
    fi
    cd build
    cmake ..
    make -j $(nproc)
    # Update the database:
    cd ../tools
    python3 dbtool.py update
    # Set zoneip
    cd ..
    XI_LOGIN=`grep -oP 'mysql_login:\s+\K\w+' conf/map.conf`
    XI_PASSWORD=`grep -oP 'mysql_password:\s+\K\w+' conf/map.conf`
    XI_DB=`grep -oP 'mysql_database:\s+\K\w+' conf/map.conf`
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
            mysql -u $XI_LOGIN -p$XI_PASSWORD $XI_DB -e "UPDATE zone_settings SET zoneip = '$IP';"
            # Following line used for systemd service.
            #echo IP=$IP > ip.txt
            echo "Set zoneip to '$IP'!"
        else
            echo "Set zoneid skipped."
        fi
    fi
    # Run custom sql (e.g. update ports)
    #if [ -e sql/backups/custom.sql ]
    #then
    #    mysql -u $XI_LOGIN -p$XI_PASSWORD $XI_DB < sql/backups/custom.sql
    #fi
    if [ ! -z "$SERVICE" ]
    then
        sudo systemctl start $SERVICE
    fi
    echo "Update complete!"
else
    echo "Failed to apply stash. Fix conflicts then re-run."
fi
