import array
import mysql.connector

def migration_name():
    return "Extend validTargets from tinyint to smallint"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'item_usable' AND COLUMN_NAME = 'validTargets';")
    row = cur.fetchall()[0][0]
    return row == "tinyint"

def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE item_usable MODIFY COLUMN validTargets SMALLINT(3) UNSIGNED NOT NULL DEFAULT '0';")
        cur.execute("ALTER TABLE spell_list  MODIFY COLUMN validTargets SMALLINT(3) UNSIGNED NOT NULL DEFAULT '0';")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
