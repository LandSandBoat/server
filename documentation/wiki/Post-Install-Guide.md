# Post-Install Guide

## Changing Game Settings

Various details about the game can be changed via editing the settings files. Settings are located in `settings/` and require a server reboot to apply. If you edit the settings files in `settings/default` nothing will happen. These are used as default values for the settings if you don't copy any files from `settings/default` to `settings/`.

## Making a Game Master Character

After creating your first character you'll want to make it a GM by typing `gm TheirName 4` into your `xi_map` exe's console (this applies instantly and is accompanied by an in-game message). You can also do this by executing the following MySQL query, replacing `Name` with your character name (this will require your character to zone to take effect):

```sql
UPDATE chars SET gmlevel = 4 WHERE charname = "Name";
```

Available GM commands are found in the [scripts/commands/](https://github.com/LandSandBoat/server/tree/base/scripts/commands) folder, and a description of each command can be found at the top of the script. Commands can be used in-game using the script name with a preceding `!`, and removing `.lua`. For example, `promote.lua` is ran in game using `!promote`. This is the command you would use to make additional GMs.

#### Useful starter GM commands

* `!godmode`: Toggles god mode on the player, granting them several special abilities, including invincibility.
* `!givegil`: Gives the specified amount of gil to GM or target player.
* `!giveexp`: Gives the GM or target player experience points.
* `!togglegm`: Toggles a GMs nameflags/icon.
* `!speed`: Sets the players movement speed.
* `!zone`: Teleports a player to the given zone (can be used with autotranslate, ie. `!zone {Port Bastok}`)

Make sure you look in `scripts/commands` for more commands!

## Making the Server Available to the Internet

To reach the server from anywhere other than the machine it runs on, the `zoneip` field for every zone in the `zone_settings` table must hold the address clients will connect to.

`dbtool` does this for you. From the `server` directory, run `python3 ./tools/dbtool.py` (Windows: `py -3 ./tools/dbtool.py`), choose `t. Maintenance Tasks`, then `2. Set zone IP addresses`:

```txt
o------------------------------------------o
|          Set Zone IP Addresses           |
o------------------------------------------o
| 1. Local only (127.0.0.1)                |
| 2. Local network (auto-detect LAN IP)    |
| 3. Public IP (via ident.me)              |
| m. Manual entry                          |
| q. Quit to tasks menu                    |
o------------------------------------------o
```

Pick the one that matches how players will reach you:

* **Local only**: you are the only player, connecting from the same machine.
* **Local network**: players are on your LAN. `dbtool` detects the host's LAN address, e.g. `192.168.0.11`.
* **Public IP**: players connect over the internet. `dbtool` looks your address up through `ident.me`.
* **Manual entry**: anything else.

Setting a public IP is not enough on its own. You also need the [ports below](#port-forwarding) forwarded and open.

### These settings are wiped by updates

⚠️ `zone_settings` is not a protected table. Any database update or reset overwrites your `zoneip` values, and players will not be able to connect until you set them again.

Do not rely on remembering. Make the change reproducible:

* Put it in a [module](Module-Guide), which survives updates and is the better option once you are running a server for other people.

## Port Forwarding

Make sure you have the following ports forwarded by your router and open in any firewall software if accessing the server over a network:

```txt
TCP ports: 54230, 54231, 54001, 54002, 51220
UDP port: 54230
```

## Database Management

By default, dbtool will offer to backup your whole database into `server/sql/backups/` whenever it performs an update. You can turn this off and do manual backups either with the TUI, or by running the commands below from the `server` directory.

Back up everything:

```sh
python3 ./tools/dbtool.py backup
```

Back up only sensitive player data:

```sh
python3 ./tools/dbtool.py backup lite
```

Windows users: `py -3` instead of `python3`.

The tables it backs up with the `lite` argument are defined in `server/tools/config.yaml` (created automatically by dbtool the first time you run it). The backups can be imported using the **Restore/Import** command in dbtool.

## Executing a MySQL Query

Linux and Windows users with MySQL in their PATH can execute a query from the terminal using the following format:

```sh
mysql -u xi -ppassword xidb -e "QUERY"
```

Where **xi**, **password**, **xidb**, and **QUERY** are changed to your needs. Windows users can also use the query tab in HeidiSQL (default keybind is CTRL+T).

## Server Customisation

During early experimentation it's probably fine for you to tinker with the main files of the repo to get a feel for how things fit together. Once you start to scale up, pulling updates regularly from LandSandBoat ("upstream"), trying to track your changes against the base repo - you're going to want to start using `modules`. You can read the module guide [here](https://github.com/LandSandBoat/server/wiki/Module-Guide).

## See Also

* [Database Management](Database-Management)
* [Useful SQL Queries](Useful-SQL-queries)
* [Common Tasks](Miscellaneous-Server)
* [Development Articles](Development)
