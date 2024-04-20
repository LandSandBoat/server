import mariadb


def migration_name():
    return "Adding expiry column to char_vars and server_variables table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure unity_leader column exists in char_profile
    cur.execute("SHOW COLUMNS FROM char_vars LIKE 'expiry'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_vars \
        ADD COLUMN `expiry` int(11) NOT NULL DEFAULT 0;"
        )
        cur.execute(
            "ALTER TABLE server_variables \
        ADD COLUMN `expiry` int(11) NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
