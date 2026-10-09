import mariadb


def migration_name():
    return "Adding MON to char_jobs table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_jobs LIKE 'mon'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_jobs \
                ADD COLUMN `mon` tinyint(2) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
