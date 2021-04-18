#!/bin/bash

# Check if exists
if [ -e /etc/systemd/system/topaz.service ]
then
    echo "Topaz service already exists!"
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
echo "Create a user to run the Topaz service, leave blank for default. (default: topaz)"
echo "WARNING! This user will need access to the current directory."
read -r -p "User: " XI_USER
if [ -z "$XI_USER" ]
then
    XI_USER="topaz"
fi
if [ $OS = "debian" ] || [[ $OS_LIKE =~ $DEBIAN ]]
then
    adduser --system --no-create-home --group --quiet $XI_USER || true
elif [ $OS = "arch" ] || [[ $OS_LIKE =~ $ARCH ]]
then
    useradd -r -s /usr/bin/nologin $XI_USER || true
else
    echo "Sorry, this OS is unsupported at this time." && exit
fi
# Give user permission to start and stop the service
cat > /etc/sudoers.d/$XI_USER << SUDO
$XI_USER ALL= NOPASSWD: /bin/systemctl restart topaz.service
$XI_USER ALL= NOPASSWD: /bin/systemctl stop topaz.service
$XI_USER ALL= NOPASSWD: /bin/systemctl start topaz.service
SUDO
# Systemd combined service
SYSTEMD_TOPAZ="""
[Unit]
Description=Topaz - FFXI Server Emulator
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
Description=Topaz Game Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=topaz.service
After=topaz.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
# For multiple map servers:
# - Make a copy of this file for each server. Rename appropriately, e.g. topaz_game-cities.service
# - Uncomment line in update.sh 'echo IP=\$IP > ip.txt'.
# - Change the zone ports in zone_settings table. A custom.sql file is useful for this, see update.sh.
# - Run update.sh and change your server IP. Manually type the IP even if you're not changing it.
# - Remove the line below, 'ExecStart=$PPWD/topaz_game'.
# - Uncomment and edit the 2 lines below with the appropriate port and log location for each zone server.
#EnvironmentFile=$PPWD/ip.txt
#ExecStart=$PPWD/topaz_game --ip \$IP --port 54230 --log $PPWD/log/map_server.log
ExecStart=$PPWD/topaz_game

[Install]
WantedBy=topaz.service
"""
# Systemd connect server service
SYSTEMD_CONNECT="""
[Unit]
Description=Topaz Connect Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=topaz.service
After=topaz.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/topaz_connect

[Install]
WantedBy=topaz.service
"""
# Systemd search server service
SYSTEMD_SEARCH="""
[Unit]
Description=Topaz Search Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=topaz.service
After=topaz.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/topaz_search

[Install]
WantedBy=topaz.service
"""
# Create services and enable child services
usermod -aG $XI_USER $SUDO_USER
chown -R $XI_USER:$XI_USER $PPWD
chmod -R g=u $PPWD 2>/dev/null
echo "$SYSTEMD_TOPAZ" > /etc/systemd/system/topaz.service
echo "$SYSTEMD_GAME" > /etc/systemd/system/topaz_game.service
echo "$SYSTEMD_CONNECT" > /etc/systemd/system/topaz_connect.service
echo "$SYSTEMD_SEARCH" > /etc/systemd/system/topaz_search.service
chmod 755 /etc/systemd/system/topaz*
systemctl daemon-reload
systemctl enable topaz_game topaz_connect topaz_search
echo "Services installed!"
echo "Start with 'systemctl start topaz', enable start on boot with 'systemctl enable topaz'."