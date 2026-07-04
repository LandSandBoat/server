import mariadb


def migration_name():
    return "Add rename flag to char_flags"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_flags LIKE 'rename';")
    return cur.fetchone() is None


def migrate(cur, db):
    try:
        cur.execute("""
                    ALTER TABLE char_flags
                        ADD COLUMN `rename` boolean NOT NULL DEFAULT FALSE;
                    """)
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
