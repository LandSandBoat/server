import mysql.connector
from mysql.connector import Error
import re
import spell_blobs_to_spell_table
import unnamed_flags
import char_unlock_table_columns
import HP_masks_to_blobs
import crystal_storage
import broken_linkshells
import spell_family_column
import mission_blob_extra
import cop_mission_ids

credentials = {}
db = None
cur = None

def connect():
    print("Loading conf/map.conf")

    # Grab mysql credentials
    filename = "../conf/map.conf"

    global credentials
    global db
    global cur

    with open(filename) as f:
        while True:
            line = f.readline()

            if not line: break

            match = re.match(r"(mysql_\w+):\s+(\S+)", line)

            if match:
                credentials[match.group(1)] = match.group(2)

    database = credentials["mysql_database"]
    host = credentials["mysql_host"]
    port = int(credentials["mysql_port"])
    login = credentials["mysql_login"]
    password = credentials["mysql_password"]

    print(database, host, port, login, password)

    db = mysql.connector.connect(host=host,
            user=login,
            passwd=password,
            db=database,
            port=port,
            use_pure=True)

    cur = db.cursor()

    print("Connected to database " + database)

def close():
    print("Closing connection...")
    cur.close()
    db.close()

def run_migration(migration):
    # Ensure things like new table exists
    migration.check_preconditions(cur)

    # Don't run migration twice
    if not migration.needs_to_run(cur):
        print("Already ran " + migration.migration_name() + " skipping...")
        return

    print("Running migrations for " + migration.migration_name())

    migration.migrate(cur, db)

    print("[Success] Done running " + migration.migration_name())

def run_all_migrations():
    connect()

    run_migration(unnamed_flags)
    run_migration(spell_blobs_to_spell_table)
    run_migration(char_unlock_table_columns)
    run_migration(HP_masks_to_blobs)
    run_migration(crystal_storage)
    run_migration(broken_linkshells)
    run_migration(spell_family_column)
    run_migration(mission_blob_extra)
    run_migration(cop_mission_ids)
    close()

    print("Finished running all migrations")
    success = input("Please close the window")

if __name__ == "__main__":
    run_all_migrations()
