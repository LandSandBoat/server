import mariadb


def migration_name():
    return "Drop legacy mob_species_system table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW TABLES LIKE 'mob_species_system'")
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("DROP TABLE IF EXISTS `mob_species_system`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
