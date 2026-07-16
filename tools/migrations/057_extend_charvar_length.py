import mariadb


def migration_name():
    return "Adjusting char_var default varname size to 64"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # check
    cur.execute(
        "show columns from char_vars where field = 'varname' and type = 'varchar(30)';"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    pass
    try:
        cur.execute(
            "ALTER TABLE char_vars MODIFY varname varchar(64);"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
