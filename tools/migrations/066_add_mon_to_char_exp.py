import mariadb


def migration_name():
    return "Adding MON to char_exp table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_exp LIKE 'mon'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_exp \
                ADD COLUMN `mon` smallint(5) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
