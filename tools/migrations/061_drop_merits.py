import mariadb


def migration_name():
    return "Drop legacy merits table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW TABLES LIKE 'merits'")
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("DROP TABLE IF EXISTS `merits`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
