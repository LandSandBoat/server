#!/bin/bash

# Check if exists
if [ -e /etc/systemd/system/ixion.service ]
then
    echo "Ixion service already exists!"
    exit
fi
# Make sure its running with root
if [ $EUID != 0 ]
then
  echo "Root permissions required, starting with sudo."
  chmod +x "$0"
  sudo "$0" "$@"
  exit $?
fi
# Check OS (for addding user)
if [ -f /etc/os-release ]
then
    . /etc/os-release
    OS=$ID
    OS_LIKE=$ID_LIKE
fi
PPWD="$(dirname "$(pwd)")"
DEBIAN="^debian|[[:space:]]debian|^ubuntu|[[:space:]]ubuntu"
ARCH="^arch|[[:space:]]arch"
# Try to create new user
echo "Create a user to run the Ixion service, leave blank for default. (default: ixion)"
echo "WARNING! This user will need access to the current directory."
read -r -p "User: " IXION_USER
if [ -z "$IXION_USER" ]
then
    IXION_USER="ixion"
fi
if [ $OS = "debian" ] || [[ $OS_LIKE =~ $DEBIAN ]]
then
    adduser --system --no-create-home --group --quiet $IXION_USER || true
elif [ $OS = "arch" ] || [[ $OS_LIKE =~ $ARCH ]]
then
    useradd -r -s /usr/bin/nologin $IXION_USER || true
else
    echo "Sorry, this OS is unsupported at this time." && exit
fi
# Give user permission to start and stop the service
cat > /etc/sudoers.d/$IXION_USER << SUDO
$IXION_USER ALL= NOPASSWD: /bin/systemctl restart ixion.service
$IXION_USER ALL= NOPASSWD: /bin/systemctl stop ixion.service
$IXION_USER ALL= NOPASSWD: /bin/systemctl start ixion.service
SUDO
# Systemd combined service
SYSTEMD_IXION="""
[Unit]
Description=Ixion - FFXI Server Emulator
After=mysql.service

[Service]
Type=oneshot
ExecStart=/bin/true
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
"""
# Systemd game server service
SYSTEMD_GAME="""
[Unit]
Description=Ixion Game Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=ixion.service
After=ixion.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$IXION_USER
Group=$IXION_USER
WorkingDirectory=$PPWD
# For multiple map servers:
# - Make a copy of this file for each server. Rename appropriately, e.g. ixion_game-cities.service
# - Uncomment line in update.sh 'echo IP=\$IP > ip.txt'.
# - Change the zone ports in zone_settings table. A custom.sql file is useful for this, see update.sh.
# - Run update.sh and change your server IP. Manually type the IP even if you're not changing it.
# - Remove the line below, 'ExecStart=$PPWD/ixion_game'.
# - Uncomment and edit the 2 lines below with the appropriate port and log location for each zone server.
#EnvironmentFile=$PPWD/ip.txt
#ExecStart=$PPWD/ixion_game --ip \$IP --port 54230 --log $PPWD/log/map_server.log
ExecStart=$PPWD/ixion_game

[Install]
WantedBy=ixion.service
"""
# Systemd connect server service
SYSTEMD_CONNECT="""
[Unit]
Description=Ixion Connect Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=ixion.service
After=ixion.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$IXION_USER
Group=$IXION_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/ixion_connect

[Install]
WantedBy=ixion.service
"""
# Systemd search server service
SYSTEMD_SEARCH="""
[Unit]
Description=Ixion Search Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=ixion.service
After=ixion.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$IXION_USER
Group=$IXION_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/ixion_search

[Install]
WantedBy=ixion.service
"""
# Create services and enable child services
usermod -aG $IXION_USER $SUDO_USER
chown -R $IXION_USER:$IXION_USER $PPWD
chmod -R g=u $PPWD 2>/dev/null
echo "$SYSTEMD_IXION" > /etc/systemd/system/ixion.service
echo "$SYSTEMD_GAME" > /etc/systemd/system/ixion_game.service
echo "$SYSTEMD_CONNECT" > /etc/systemd/system/ixion_connect.service
echo "$SYSTEMD_SEARCH" > /etc/systemd/system/ixion_search.service
chmod 755 /etc/systemd/system/ixion*
systemctl daemon-reload
systemctl enable ixion_game ixion_connect ixion_search
echo "Services installed!"
echo "Start with 'systemctl start ixion', enable start on boot with 'systemctl enable ixion'."