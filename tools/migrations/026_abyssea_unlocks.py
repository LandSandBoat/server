import mariadb


def migration_name():
    return "Adding traverser_start column to char_unlocks table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure unity_leader column exists in char_profile
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'traverser_start'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_unlocks \
        ADD COLUMN `traverser_start` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, \
        ADD COLUMN `traverser_claimed` int(10) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
