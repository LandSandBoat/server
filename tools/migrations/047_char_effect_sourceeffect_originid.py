import mariadb


def migration_name():
    return "Adding sourcetype, sourctypeparam, originid columns to char_effects table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure crystal columns exist in char_points
    cur.execute("SHOW COLUMNS FROM char_effects LIKE 'sourcetype'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_effects \
        ADD COLUMN `sourcetype` smallint(10) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `sourcetypeparam` int(10) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `originid` int(10) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
