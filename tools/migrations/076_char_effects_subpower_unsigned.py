import mariadb


def migration_name():
    return "Make char_effects subpower unsigned to match the server"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute(
        "SHOW COLUMNS FROM char_effects WHERE Field = 'subpower' AND Type NOT LIKE '%unsigned%';"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_effects MODIFY subpower smallint(5) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
