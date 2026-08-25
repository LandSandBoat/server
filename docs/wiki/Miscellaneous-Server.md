# Common Tasks

## Maximising performance

To give your server the best chance of providing a snappy and stable gameplay experience, you should ensure the following:

### Build and run in RelWithDebInfo mode

Build `RelWithDebInfo` before you let players connect. A lot of debug information and tooling is removed from the build, and it runs much faster than a `Debug` build. Only revert to `Debug` when you are chasing a serious problem.

`RelWithDebInfo` is the `default` CMake preset, so this is what you get from:

```sh
python3 ./tools/build.py
```

Or, driving CMake yourself:

```sh
cmake --preset default
cmake --build --preset default
```

In Visual Studio, set the configuration dropdown to `Default (RelWithDebInfo)`. Check it after every reconfigure. Visual Studio often resets it to `Debug`.

### Use a bare-metal/real machine

Virtual machines, machine images, stuff in the cloud etc. are all very cool and very convenient, but nothing can beat using a powerful real machine for performance. You'll get the best results from using a dedicated machine in your home, or rented from a third-party provider.

### Minimise inter-process latency

Your server processes (`xi_connect`, `xi_map`, `xi_search`, `xi_world`, etc.) and your database service (`MariaDB database server`, `mariadb.service`, etc.) should be running on the same machine. Splitting these processes/services onto different real/virtual machine introduces latency into systems that are blocking and will have a direct effect on the experience of your players.

### Avoid heavy database operations

Despite all of the effort that has gone into reducing how much the database is read and written during regular gameplay, the database is still critical for performance for all areas of the server. If you host a website and are hammering the database with heavy queries, or have custom commands that are making queries, then your players will notice a drop in performance. Try to time heavy database operations like taking backups in the lowest population times of your server (4am, etc).

## Setting up a multi-process server

### What is multi-process?

The `xi_map` process is [single-threaded](https://en.wikipedia.org/wiki/Thread_(computing)) by design, this means that it cannot take advantage of any additional cores a machine may have. With all of the work that has gone into performance and stability of the server it is not really a concern until you have a player load sufficiently large to introduce lag or instability.

One advantage of being (and remaining) single-threaded is that a whole category of difficult-to-diagnose-and-fix bugs are kept out of the codebase and it's easier for newer developers to join in and get started.

In order to utilise additional cores on a machine, we use [ZMQ](https://zeromq.org/) to allows us to launch multiple copies of the `xi_map` process, communicate with eachother, and have them split the workload.

From the ZMQ website:

```txt
ZeroMQ (also known as ØMQ, 0MQ, or zmq) looks like an embeddable networking library but acts like a concurrency framework.
```

Even though ZMQ communicates over TCP sockets, the intent of its usage is use on the same physical machine. It _needs_ to operate as quickly as possible.

`Multi-process vs. Clustering`: This configuration is often called [Clustering](https://en.wikipedia.org/wiki/Computer_cluster), but we tend not to agree with how the community uses this naming. A complete multi-process system serving all the zones required for a server can be described as a single cluster, but a single process within the system servicing multiple zones is not in itself a cluster.

To us, an announcement of `We are restarting the Dynamis cluster` is a misnomer. Unfortunately for us, the name has taken hold in the community, so you do you 👍.

### When should I use multi-process?

There is **absolutely no need** to set up a multi-process server if your server is regularly hosting less than **100 concurrent players**.

However, if your server is regularly hosting more than 100 concurrent players or you have events where 50 or more players are in the same zone, and this leads to unacceptable additional lag, then you should consider using multi-process.

This is also valid if you have particularly crash-prone content and want to protect the rest of the server zones from crashes in that content.

### How do I set it up?

You can take a look at our CI job `MultiInstance_Startup_Checks_Linux` in [build.yml](https://github.com/LandSandBoat/server/blob/base/.github/workflows/build.yml).

By default, all zones in `zone_settings` are assigned a `zoneport` of `54230`, which is the default port used when you launch `xi_map`.

Any zones you want to move onto a different process you can assign a different `zoneport`, like `54231`.

In the case of our CI, we set every other zone to use `zoneport` `54231`:

```sql
UPDATE xidb.zone_settings SET zoneport = 54231 WHERE zoneid % 2 = 0;
```

Then when we launch our server processes we make sure to specify a process that uses the original `zoneport` and the new `zoneport`:

```sh
    screen -d -m -S xi_map ./xi_map --ip 127.0.0.1 --port 54230 --log map-server-0.log
    screen -d -m -S xi_map ./xi_map --ip 127.0.0.1 --port 54231 --log map-server-1.log
```

**NOTE**: You must make sure to specify `--ip` for each process you run. This should match up to whatever you have set in `zone_settings`. See the [Post-Install Guide](https://github.com/LandSandBoat/server/wiki/Post-Install-Guide#making-the-server-available-to-the-internet) if you need to change this.

It's also recommended (as above) that you specify different log files to be used by each process.

### Possible configurations

You can set any 'split' between your processes that you'd like. Remember that each process takes up memory equal to how many zones it is hosting, plus all information required for running the game, so if you run too many processes you'll starve your machine of resources and introduce lag.

```sql
-- Any zones with a name that contains 'Dynamis'

UPDATE xidb.zone_settings SET zoneport = 54231 WHERE `name` LIKE "%Dynamis%";
```

```sql
-- Split according to their 'ZONE_TYPE'

-- ZONE_TYPE::CITY
UPDATE xidb.zone_settings SET zoneport = 54230 WHERE zonetype = 1;
-- ZONE_TYPE::OUTDOORS
UPDATE xidb.zone_settings SET zoneport = 54231 WHERE zonetype = 2;
-- ZONE_TYPE::DUNGEON
UPDATE xidb.zone_settings SET zoneport = 54232 WHERE zonetype = 3;
-- ZONE_TYPE::BATTLEFIELD
UPDATE xidb.zone_settings SET zoneport = 54233 WHERE zonetype = 4;
-- ZONE_TYPE::DYNAMIS
UPDATE xidb.zone_settings SET zoneport = 54234 WHERE zonetype = 5;
-- ZONE_TYPE::DUNGEON_INSTANCED
UPDATE xidb.zone_settings SET zoneport = 54235 WHERE zonetype = 6;
-- ZONE_TYPE::LIMBUS
UPDATE xidb.zone_settings SET zoneport = 54236 WHERE zonetype = 7;
```

## Generating LandSandBoat patch notes

You can use `server\tools\generate_changelog.py` to generate patch notes from LandSandBoat to publish as-is, or to supplement your own patch notes.
By default, `server\tools\generate_changelog.py` will generate patch notes for the last 14 days, but it accepts an argument if you wanted to use an arbitrary number of days: `tools\generate_changelog.py 30` will generate 30 days. We automatically generate patch notes on the 1st and 15th day of the month, and store them here: <https://github.com/LandSandBoat/server/tree/website/changelogs>.

## Common Issues

### Gil not sent to the Delivery Box from the Auction House

One possible fix: Execute HeidiSQL > select your session and connect to it > select "xidb" > File > Run SQL file... > select the triggers.sql file from the `server\sql` folder > Open.

### Version Mismatch

**WE STRONGLY ADVISE AGAINST LOCKING THE SERVER TO OLDER VERSIONS. IT IS A UNIVERSALLY BAD IDEA.** It _will_ cause issues even _if_ you manage to keep both server and client versions on par!

If the server (LandSandBoat) and the client (Final Fantasy XI) don't share the same version, you'll probably get this error in the xi_connect.exe log window:

```sh
[Error] lobbyview_parse: Incorrect client version: got 000000xx_x, expected 000000xx_x
[Error] lobbyview_parse: The server must be updated to support this client version
```

**Copy** the following file from the `server\settings\default\` folder into the `server\settings\` folder and open the copied file (with the default Windows text editor (Notepad) or an external one (like  [Notepad++](https://notepad-plus-plus.org/)):

* login.lua

then modify this line:

> VER_LOCK = 2,

(replace **2** with **0**)

then save the changes and restart the **xi_connect.exe** server.

## Tweaks

### Setting up an automated Auction House with Python

#### Installing

Python and the MySQL Python Connector are needed and should already be installed if you previously followed the [Quick-Start Guide](Quick-Start-Guide).

Right click wherever you want to download the repository > Git Clone... > URL: <https://github.com/AdamGagorik/pydarkstar.git> > OK > then Close when it's done.

Its setup instructions (found **[HERE](http://adamgagorik.github.io/pydarkstar/generated/setup.html)**) are focused on a package manager named Anaconda. The below instructions are focused on pip, which comes with the stock python installer. Anaconda may work better for you if the command line is scary.

Whichever you choose, it is important to note that **LSB doesn't maintain or provide support for pydarkstar** - its a nice thing that happens to work. **PLEASE contact its author NOT US**, for any that wasn't a direct result of us screwing up our guide! Thanks for your understanding.

#### To get started via pip

Right click + holding the Shift key > context menu: Open command window here/Open PowerShell window here, then type:

```sh
py -3 -m pip
```

then enter each of these commands (hit "Enter" after each one) and it will download and install automatically:

```sh
py -3 -m pip install beautifulsoup4
py -3 -m pip install pymysql
py -3 -m pip install sqlalchemy
```

Double click on `\pydarkstar\makebin.py` to create base files then open `\pydarkstar\bin\config.yaml` with a text editor (default options are listed below, you can edit them at your convenience):

```txt
name: Zissou (will be the name of the bot displayed in the AH lists, buying and selling items)
database: xidb (change it accordingly to your database's name)
password: root (replace with your MariaDB password)
restock: 3600 (seconds between each automatic restock)
tick: 30 (seconds between each purchase will be made by the bot)
stock01: 5 (number of single items that will be restocked each tick)
stock12: 5 (number of stacks items that will be restocked each tick)
```

#### Running

1. ~~Execute \pydarkstar\pydarkstar\bin\scrub.py to build up the items list from <https://www.ffxiah.com/> (will take some time). Unfortunately you can't select the server from which the prices are pulled, if I'm correct Bahamut is the server by default. Rerun it if you want to update prices automatically.~~ **Do not run the scrape to get new prices from ffxiah. Just don't. The stock file was heavily edited to ensure you didn't create a gil printing press on your server.**

2. Execute `\pydarkstar\pydarkstar\bin\broker.py`: Script that will automatically buy/sell stuff. Let it run in the background.

3. Executing `\pydarkstar\pydarkstar\bin\refill.py` will restock items automatically.

4. Editing prices manually: open `\pydarkstar\bin\items.csv` with a text editor (0 = non listed item, add them by referring to the IDs in `\server\sql\item_equipment.sql` if necessary) and change prices accordingly.

### HeidiSQL useful querys

```sql
UPDATE auction_house SET seller_name = 'Your-choice-here';
UPDATE auction_house SET buyer_name = 'Your-choice-here';
UPDATE auction_house SET buyer_name = 'Your-choice-here' where buyer_name is null or buyer_name = 'Your-choice-here';
UPDATE auction_house SET sell_date = 'Your-choice-here' where sell_date = 'Your-choice-here';
```

### Updating Python

Updating Python: Default location of the Python installation files is: `C:\Users\Username\AppData\Local\Programs\Python`, when updating you may want to relocate old files from your old version's folder to the new one (copy/paste).

Updating modules: Make sure you check if your modules are up to date from time to time (you'll probably get reminded while running migrations scripts). To do so, open a command prompt like stated above and enter:

```sh
py -3 -m pip install --upgrade Modulename
```

### Useful GM Commands

Type `!command` in game (for other GM commands to use in place of **!command**, refer to: `\server\scripts\commands`).

!togglegm: no more aggro and the GM icon next to the character name

!togglegm + /anon: invisible through /search.

!hide: switches between being visible/invisible to players.

### Change your MariaDB password

Open: Start Menu > "MariaDB xx.x (x64)" folder > "MySQL Client (MariaDB xx.x)".

In the prompt command, you will be prompted to enter your current MySQL DB password.  Do so, hit "Enter", then enter the following commands:

```sql
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('Your-new-desired-password');
```

Hit "Enter" (returned message: "Query OK, 0 rows affected"), then type:

```sql
FLUSH PRIVILEGES;
```

Hit "Enter" (returned message: "Query OK, 0 rows affected"), then type:

```sql
exit
```

Hit "Enter" (returned message: "Bye").

How to check if it was changed correctly (while still having the same prompt command open):

```sh
mysql -u root -p
```

Hit "Enter", then type:

```sh
Enter password: Your-new-MariaDB-password
```

Hit "Enter".

```sh
exit
```

Hit "Enter" (returned message: "Bye").

Done.

### How do I set JP Midnight?

JP midnight is now coded to align with the retail JST midnight regardless of your local timezone setting and manual configuration is no longer required. There is no setting for JP Midnight and we do not recommend altering server timing behaviour as the client has hard-coded expectations that certain events and resets will occur at certain times.

### Auto-Starting the Server

#### Linux

Linux users can create several systemd services to automate the servers (make sure to update `/path/to/lsb`, and the User/Group):

```ini
#xi.service

[Unit]
Description=LandSandBoat - a server emulator for Final Fantasy XI
Documentation=https://github.com/LandSandBoat/server/wiki/Miscellaneous-Server#linux
After=mysql.service

[Service]
Type=oneshot
ExecStart=/bin/true
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

```ini
#xi_map.service

[Unit]
Description=XI Map Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
# You can use your regular system user or a custom user you make
# ie User=xiplayer or User=myusername
User=
# omit Group and it will use the Users primary group. Otherwise you can explicitly list it
# Group=
WorkingDirectory=/path/to/lsb
# For multiple map servers:
# - Make a copy of this file for each server. Rename appropriately, e.g. topaz_game-cities.service
# - Add this to a file named ip.txt in the topaz folder, replacing YOUR_PUBLIC_IP with your IP: "IP=YOUR_PUBLIC_IP"
# - Change the zone ports in zone_settings table. A custom.sql file is useful for this.
# - Remove the line below, 'ExecStart=/path/to/topaz_game'.
# - Uncomment and edit the 2 lines below with the appropriate port and log location for each zone server.
#EnvironmentFile=/path/to/topaz/ip.txt
#ExecStart=/path/to/topaz/topaz_game --ip $IP --port 54230 --log /path/to/log/map_server.log
ExecStart=/path/to/lsb/xi_map

[Install]
WantedBy=xi.service
```

```ini
#xi_connect.service

[Unit]
Description=XI Connect Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
# You can use your regular system user or a custom user you make
# ie User=xiplayer or User=myregularusername
User=
# omit Group and it will use the Users primary group. Otherwise you can explicitly list it
# Group=
WorkingDirectory=/path/to/lsb
ExecStart=/path/to/lsb/xi_connect

[Install]
WantedBy=xi.service
```

```ini
#xi_search.service

[Unit]
Description=XI Search Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
# You can use your regular system user or a custom user you make
# ie User=xiplayer or User=myregularusername
User=
# omit Group and it will use the Users primary group. Otherwise you can explicitly list it
#Group=
WorkingDirectory=/path/to/lsb
ExecStart=/path/to/lsb/xi_search

[Install]
WantedBy=xi.service
```

```ini
#xi_world.service

[Unit]
Description=XI World Server
Wants=network.target
StartLimitIntervalSec=120
StartLimitBurst=5
PartOf=xi.service
After=xi.service

[Service]
Type=simple
Restart=always
RestartSec=5
# You can use your regular system user or a custom user you make
# ie User=xiplayer or User=myregularusername
User=
# omit Group and it will use the Users primary group. Otherwise you can explicitly list it
#Group=
WorkingDirectory=/path/to/lsb
ExecStart=/path/to/lsb/xi_world

[Install]
WantedBy=xi.service
```

After adding these to `/etc/systemd/system/`, run `systemctl daemon-reload` followed by `systemctl enable xi_connect xi_map xi_search xi_world`. You can start/stop all the servers at once with `systemctl start/stop xi` or each individual service separately. To enable auto-start, type `systemctl enable xi`. Make sure lsb is in a location accessible to the user that will be running the service, and the correct permissions are set.
