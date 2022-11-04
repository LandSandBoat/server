import mariadb


def migration_name():
    return "Adjusting char_effects table column subid size to int."


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure subid is currently smallint
    cur.execute(
        "SHOW COLUMNS FROM char_effects WHERE FIELD = 'subid' AND TYPE = 'smallint(5) unsigned';"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_effects MODIFY subid int(10) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
