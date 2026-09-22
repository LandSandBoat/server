import mariadb


def migration_name():
    return "Dropping dominant_gene and recessive_gene from char_chocobos"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_chocobos LIKE 'dominant_gene'")
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE char_chocobos \
                DROP COLUMN `dominant_gene`, \
                DROP COLUMN `recessive_gene`;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
