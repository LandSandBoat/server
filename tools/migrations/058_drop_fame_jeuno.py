import mariadb


def migration_name():
    return "Dropping fame_jeuno column from char_profile (Jeuno fame is derived from nation fame)"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_profile LIKE 'fame_jeuno'")
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE `char_profile` DROP COLUMN `fame_jeuno`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
