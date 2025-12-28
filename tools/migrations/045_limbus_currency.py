import mariadb


def migration_name():
    return "Adding temenos_units, apollyon_units columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure waypoints column exists in char_unlocks
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'temenos_units'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
                ADD COLUMN `temenos_units` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `apollyon_units` int(10) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
