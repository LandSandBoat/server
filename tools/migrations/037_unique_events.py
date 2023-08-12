import mariadb

def migration_name():
    return "Adding unique_event column to char_unlocks table"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure unique_event column exists in char_profile
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'unique_event'")

    if cur.fetchone():
        return False

    return True

def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `char_unlocks` \
            ADD COLUMN `unique_event` BLOB DEFAULT NULL AFTER `claimed_deeds`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
