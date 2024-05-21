Tools
========================

## Database Tool
`python dbtool.py`  
`python dbtool.py backup` - creates a whole database backup in `../sql/backups/`  
`python dbtool.py backup lite` - creates a backup only of tables defined in settings  
`python dbtool.py update` - performs an express update with backup and migrations if necessary  
`python dbtool.py update full` - performs a full update with backup and migrations  
`python dbtool.py migrate` - checks and performs any needed migrations

This tool creates or connects to the database defined in `../settings/network.lua`. It 
allows the user to backup or restore the database, import any `custom.sql` 
stored in `../sql/backups/`, and import the latest SQL files provided by LandSandBoat 
Development. This tool also handles data migrations for character data.

## Mob lua creator
`python create_mob_luas.py <true/false> <args>`

Will generate mob lua files with proper header comment for zone/mob name.

- `<true/false>`
  - Will clobber all mob lua files for matching mobs if `true`. Otherwise will create a file if it doesnt exist and just `touch` existing files, so their last -modified time is updated
- `<args>` define the search scope for the mobs:
  - `zone <zoneID>`
    - Generates a mob lua for every valid/spawnable mob assigned to the zoneID
  - `family <familyID>`
    - Generates a mob lua for every valid/spawnable mob with the particular mob family
  - `mobskill <mob_skill_id>`
    - Generates a mob lua for every valid/spawnable mob assigned with a skill list that contains the partciular mobskill

Example usage:
- Note that the intent of this tool is to programatically flag lua files, effort is required to do more before a commit is made
  - The extra bonus is the default content can easily be changed before running the script, i.e. to populate mixins, similar onMobInit functions, etc
- Each can have multiple values via comma-separation
- `python create_mob_luas.py true family 119`
  - Generates a mob lua for every funguar in all zones
- `python create_mob_luas.py true family 119 zone 88`
  - Generates a mob lua for every funguar in North_Gustaberg_[S]
- `python create_mob_luas.py true family 119 zone 88 mobskill 310`
  - Generates a mob lua for every funguar in North_Gustaberg_[S] that has queasyshroom in its mob_skill_list

## Price Checker
`python price_checker.py`

This tool checks NPC and guild shop prices to see if anything is being sold for less than the buyback price.

## Festive Moogle Tool
`python give_items.py`

This tool is used to distribute the following items:  
- Nomad Cap  
- Moogle Cap  
- Moogle Rod  
- Harpsichord  
- Stuffed Chocobo  
- Tidal Talisman  
- Destrier Beret  
- Chocobo Shirt  

## Announce
`python announce.py "<your message>"`

Sends `<your message>` to every character, in every zone, on every map process.  



Setup
========================

## Installing Python
`python3 --version` or `py -3 --version`

**This requires Python 3 and pip.**  
**Website:** https://www.python.org/downloads/  
Download the latest version from the website or check your package manager.

## Installing Dependencies
`pip install -r requirements.txt`

**MariaDB** - MariaDB is required to interact with the database.  
**GitPython** - GitPython is required to compare database versions.  
**PyYAML** - PyYAML is required to read/write settings.  
**Colorama** - Colorama is required to make colored terminal text.  
**zmq** - ZeroMQ is required for sending messages to the server.  
**Pylint** - Pylint is a static code analyser.  
**Black** - Black is a Python code formatter.  

## Other
`./install-systemd-service.sh` - Installs a systemd service for running the servers on Linux.  
`./run_clang_format.sh` - Formats C++ code. Run from repo root.  