import mariadb


def migration_name():
    return "Adding abyssea_conflux column to char_unlocks table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure abyssea_conflux column exists in char_unlocks
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'abyssea_conflux'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_unlocks \
        ADD COLUMN `abyssea_conflux` blob DEFAULT NULL;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
