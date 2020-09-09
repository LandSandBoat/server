import array
import mysql.connector

def migration_name():
    return "Adding family column to spell_list table"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Check family columns exist in spell_list
    cur.execute("SHOW COLUMNS FROM spell_list LIKE 'family'")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE spell_list \
        ADD COLUMN `family` smallint(4) unsigned NOT NULL DEFAULT '0' AFTER `group`;")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))