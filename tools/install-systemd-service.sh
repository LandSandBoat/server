#!/bin/bash

# Check if exists
if [ -e /etc/systemd/system/xi.service ]
then
    echo "xi service already exists!"
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
echo "Create a user to run the xi service, leave blank for default. (default: xi)"
echo "WARNING! This user will need access to the current directory."
read -r -p "User: " XI_USER
if [ -z "$XI_USER" ]
then
    XI_USER="xi"
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
$XI_USER ALL= NOPASSWD: /bin/systemctl restart xi.service
$XI_USER ALL= NOPASSWD: /bin/systemctl stop xi.service
$XI_USER ALL= NOPASSWD: /bin/systemctl start xi.service
SUDO
# Systemd combined service
SYSTEMD_xi="""
[Unit]
Description=xi - FFXI Server Emulator
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
Description=xi Game Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
# For multiple map servers:
# - Make a copy of this file for each server. Rename appropriately, e.g. xi_map-cities.service
# - Uncomment line in update.sh 'echo IP=\$IP > ip.txt'.
# - Change the zone ports in zone_settings table. A custom.sql file is useful for this, see update.sh.
# - Run update.sh and change your server IP. Manually type the IP even if you're not changing it.
# - Remove the line below, 'ExecStart=$PPWD/xi_map'.
# - Uncomment and edit the 2 lines below with the appropriate port and log location for each zone server.
#EnvironmentFile=$PPWD/ip.txt
#ExecStart=$PPWD/xi_map --ip \$IP --port 54230 --log $PPWD/log/map_server.log
ExecStart=$PPWD/xi_map

[Install]
WantedBy=xi.service
"""
# Systemd connect server service
SYSTEMD_CONNECT="""
[Unit]
Description=xi Connect Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/xi_connect

[Install]
WantedBy=xi.service
"""
# Systemd search server service
SYSTEMD_SEARCH="""
[Unit]
Description=xi Search Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/xi_search

[Install]
WantedBy=xi.service
"""

SYSTEMD_WORLD="""
[Unit]
Description=xi World Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
User=$XI_USER
Group=$XI_USER
WorkingDirectory=$PPWD
ExecStart=$PPWD/xi_world

[Install]
WantedBy=xi.service
"""
# Create services and enable child services
usermod -aG $XI_USER $SUDO_USER
chown -R $XI_USER:$XI_USER $PPWD
chmod -R g=u $PPWD 2>/dev/null
echo "$SYSTEMD_xi" > /etc/systemd/system/xi.service
echo "$SYSTEMD_GAME" > /etc/systemd/system/xi_map.service
echo "$SYSTEMD_CONNECT" > /etc/systemd/system/xi_connect.service
echo "$SYSTEMD_SEARCH" > /etc/systemd/system/xi_search.service
echo "$SYSTEMD_WORLD" > /etc/systemd/system/xi_world.service
chmod 755 /etc/systemd/system/xi*
systemctl daemon-reload
systemctl enable xi_map xi_connect xi_search xi_world
echo "Services installed!"
echo "Start with 'systemctl start xi', enable start on boot with 'systemctl enable xi'."
