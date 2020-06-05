Migrating Database
========================

This folder contains scripts to migrate your database data to a newer format. 
For example the spells column in the chars table has been separated into 
a new table, so a migration script has been created to do this for you.

First you'll need python and mysqldb installed on your computer.

## Setup

## Installing Python

This requires Python 3.4+

For Windows users, download the installation file here https://www.python.org/downloads/

For Ubuntu it's already installed. For *most* distros of GNU/Linux one or more versions of python are likely already installed and you should check your package manager.


## Installing MySQLdb

A Mysql driver is required to execute mysql commands. This and any other required dependencies can be installed by running the following from bash or command prompt/powershell:

pip install -r requirements.txt

## Running Migrations

Go into the `topaz/migrations` directory and execute the `migrate.py` file.

From the command line: `python migrate.py`

This will run all out-standing migrations and skip migrations that have already ran. 
Keep in mind no data is deleted and any unused columns are expected to be cleaned up by yourself.

