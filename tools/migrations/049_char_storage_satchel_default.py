import mariadb


def migration_name():
    return "Adjusting char_storage default satchel to size 0"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # check
    cur.execute(
        "show columns from char_storage where field = 'satchel' and `Default` = 30;"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    pass
    try:
        cur.execute(
            "ALTER TABLE char_storage MODIFY satchel tinyint(2) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
