# Making Persistent Changes
When updates happen to our SQL files, the import process will overwrite any changes you've made to those tables in your database. To keep your database up to date with the latest changes, as well as maintain your own custom changes, it is recommended that you save your changes as SQL queries in a `.sql` file in `server\sql\backups\`, then import that file after an update using either the dbtool **Restore/Import** function or another method of importing, such as:
```
mysql -u server -ppassword xidb < server/sql/backups/custom.sql
```

# dbtool
The database update, backup, and restore tool is called dbtool and is located in the `server\tools\` folder. You can execute it using Python3 by typing `py -3 dbtool.py` in a PowerShell window on Windows or `python3 dbtool.py` in a Linux terminal. After opening it, it will create a `config.yaml` file that saves its settings.

- Backup
  - Using the default interface, select "3. Backup" and press `y` to create a full database backup in `server\sql\backups\`.

  **OR**

  - Use the command `dbtool.py backup` to create a full database backup in `server\sql\backups\`.

    - Use the command `dbtool.py backup lite` to create a partial database backup in `server\sql\backups\`. This will contain only the tables listed in `config.yaml`.

- Restore/Import
  - Using the default interface, select "4. Restore/Import", press `y` to create a full database backup or anything else to continue without a backup, then enter the number of the desired backup to import. Read the prompt carefully and confirm the import. 

- Update
  - Using the default interface, select "1. Update", press `y` to create a full database backup or anything else to continue without a backup, review the changes then press `y` to import all files in `server\sql\` except those defined in `config.yaml`. It will then check for any needed migrations, and finally it will check if there was a version update and if your `login.lua` settings file should be updated with a new version number.

  **OR**

  - Use the command `dbtool.py update`. This will create a full backup, perform an express update (defined above), perform any needed migrations, and finally update your targeted client version in the `login.lua` settings file.
    - The automatic backup and target client update can be disabled in `config.yaml`.
    - Use the command `dbtool.py update full` to ignore the express part of the update and import all files in `server\sql\` except those defined in `config.yaml`.

## ⚠Protected Tables⚠
  By default, these files will be left untouched during updates using dbtool. This is also the same list of tables used for `dbtool.py backup lite`. You can edit this list using dbtool or editing `config.yaml`.
  ```
  - accounts.sql
  - accounts_banned.sql
  - auction_house.sql
  - char_blacklist.sql
  - char_effects.sql
  - char_equip.sql
  - char_exp.sql
  - char_inventory.sql
  - char_jobs.sql
  - char_look.sql
  - char_merit.sql
  - char_pet.sql
  - char_points.sql
  - char_profile.sql
  - char_skills.sql
  - char_spells.sql
  - char_stats.sql
  - char_storage.sql
  - char_style.sql
  - char_unlocks.sql
  - char_vars.sql
  - chars.sql
  - conquest_system.sql
  - delivery_box.sql
  - linkshells.sql
  - server_variables.sql
  - unity_system.sql
  ```
