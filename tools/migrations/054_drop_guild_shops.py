import mariadb


def migration_name():
    return "Drop legacy guild_shops table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW TABLES LIKE 'guild_shops'")
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("DROP TABLE IF EXISTS `guild_shops`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
