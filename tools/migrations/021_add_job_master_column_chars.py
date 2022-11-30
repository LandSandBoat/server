import mariadb


def migration_name():
    return "Adding job_master column to chars table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure job_master column exists in char_profile
    cur.execute("SHOW COLUMNS FROM chars LIKE 'job_master'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE chars \
        ADD COLUMN `job_master` int(2) unsigned NOT NULL DEFAULT '1' AFTER `mentor`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
