import mariadb


def migration_name():
    return "Adding unity_leader column to char_profile table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure unity_leader column exists in char_profile
    cur.execute("SHOW COLUMNS FROM char_profile LIKE 'unity_leader'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_profile \
        ADD COLUMN `unity_leader` int(2) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
