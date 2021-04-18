Migrating Database
========================

This folder contains scripts to migrate your database data to a newer format. 
For example the spells column in the chars table has been separated into 
a new table, so a migration script has been created to do this for you.

## Running Migrations

Go into the `topaz/tools` directory and execute the `dbtool.py` file.

From the command line: `python dbtool.py`

This will run all out-standing migrations and skip migrations that have already ran. 
Keep in mind no data is deleted and any unused columns are expected to be cleaned up by yourself.

