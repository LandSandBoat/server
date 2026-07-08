import mariadb


def migration_name():
    return "Adding unity columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure daily_tally column exists in char_points
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'current_accolades'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
        ADD COLUMN `current_accolades` int(10) unsigned NOT NULL DEFAULT '0', \
        ADD COLUMN `prev_accolades` int(10) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
