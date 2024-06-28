import mariadb


def migration_name():
    return "Adding plaudits column to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure waypoints column exists in char_unlocks
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'plaudits'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
        ADD COLUMN `plaudits` smallint(5) DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
