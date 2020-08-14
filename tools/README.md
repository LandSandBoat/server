Tools
========================

## Database Tool
`python dbtool.py`  
`python dbtool.py backup` - creates a whole database backup in `../sql/backups/`  
`python dbtool.py backup lite` - creates a backup only of tables defined in settings  
`python dbtool.py update` - performs an express update with backup and migrations if necessary  
`python dbtool.py update full` - performs a full update with backup and migrations  
`python dbtool.py migrate` - checks and performs any needed migrations

This tool creates or connects to the database defined in `../conf/map.conf`. It 
allows the user to backup or restore the database, import any `custom.sql` 
stored in `../sql/backups/`, and import the latest SQL files provided by Project 
Topaz. This tool also handles data migrations for character data.

## Price Checker
`python price_checker.py`

This tool checks npc and guild shop prices to see if anything is being sold for less than the buyback price.

## Festive Moogle Tool
`python give_items.py`

This tool is used to distribute the following items:  
-Nomad Cap  
-Moogle Cap  
-Moogle Rod  
-Harpsichord  
-Stuffed Chocobo  
-Tidal Talisman  
-Destrier Beret  
-Chocobo Shirt  


Setup
========================

## Installing Python
`python --version`

**This requires Python 3.4+ and pip.**  
**Website:** https://www.python.org/downloads/  
Download the latest version from the website or check your package manager.

## Installing Dependencies
`pip install -r requirements.txt`

**MySQL Connector/Python** - MySQL Connector/Python is required to interact with the database.  
**GitPython** - GitPython is required to compare database versions.  
**PyYAML** - PyYAML is required to read/write settings.  
**Colorama** - Colorama is required to make colored terminal text.  