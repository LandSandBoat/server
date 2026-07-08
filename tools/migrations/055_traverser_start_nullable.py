import mariadb


def migration_name():
    return "Make traverser_start nullable"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("DESCRIBE char_unlocks traverser_start;")
    return cur.fetchone()[2] == "NO"  # This returns the content of the Null column


def migrate(cur, db):
    try:
        cur.execute("""
                    ALTER TABLE char_unlocks
                        MODIFY traverser_start TIMESTAMP NULL DEFAULT NULL;
                    """)
        cur.execute("""
                    UPDATE char_unlocks
                    SET traverser_start = NULL
                    WHERE traverser_start = '0000-00-00 00:00:00';
                    """)
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
