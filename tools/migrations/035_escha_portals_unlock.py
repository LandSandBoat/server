import array
import mariadb

def migration_name():
    return "Adding eschan_portals column to char_unlocks table"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure escha_portal column exists in char_profile
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'eschan_portals'")

    if cur.fetchone():
        return False

    return True

def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `char_unlocks` \
            ADD COLUMN `eschan_portals` BLOB DEFAULT NULL AFTER `waypoints`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
