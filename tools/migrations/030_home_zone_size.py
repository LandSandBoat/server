import mariadb


def migration_name():
    return "Adjusting home_zone size to smallint."


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure home_zone is currently tinyint
    cur.execute(
        "SHOW COLUMNS FROM chars WHERE FIELD = 'home_zone' AND TYPE = 'tinyint(3) unsigned';"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE chars MODIFY home_zone smallint(5) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
