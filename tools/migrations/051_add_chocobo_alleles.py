import mariadb


def migration_name():
    return "Adding allele columns to char_chocobos table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_chocobos LIKE 'allele1'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE char_chocobos \
                ADD COLUMN `allele1` tinyint unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `allele2` tinyint unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `allele3` tinyint unsigned NOT NULL DEFAULT 0;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
