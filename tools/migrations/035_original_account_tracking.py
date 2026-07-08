import mariadb


def migration_name():
    return "Adding original_accid column to chars table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM chars LIKE 'original_accid';")

    row = cur.fetchone()
    if row:
        return False

    return True


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `chars` \
            ADD COLUMN `original_accid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `accid`;"
        )
        db.commit()

    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
