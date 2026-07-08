import mariadb


def migration_name():
    return "Adding instance_zone column to instance_list table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure instance_zone column exists in char_points
    cur.execute("SHOW COLUMNS FROM instance_list LIKE 'instance_zone'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE instance_list \
        ADD COLUMN `instance_zone` tinyint(3) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
