Migrating Database
========================

This folder contains python scripts to migrate your database data to a newer
format. For example the spells column in the chars table has been separated
into a new table, so a migration script has been created to do this for you.

First you'll need python and mysqldb installed on your computer.

## Setup

## Installing Python

This requires Python 2.7+.

For Windows user, download the installation file for [64-bit computers](https://www.python.org/ftp/python/2.7.10/python-2.7.10.amd64.msi) or [32-bit computers](https://www.python.org/ftp/python/2.7.10/python-2.7.10.msi).

For Ubuntu it's already installed.


## Installing MySQLdb

A Mysql driver is required to execute mysql commands. This and any other required dependencies can be installed by running the following from bash or command prompt/powershell:

pip install -r requirements.txt

## Running Migrations

Go into the `topaz/migrations` directory and execute the `migrate.py` file.

From the command line: `python migrate.py`

This will run all out-standing migrations and skip migrations that have already
ran. Keep in mind no data is deleted and unused columns is expected to be
cleaned up by yourself.
