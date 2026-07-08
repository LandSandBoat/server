import mariadb


def migration_name():
    return "Rename colour column to color in char_chocobos"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM char_chocobos LIKE 'color';")

    row = cur.fetchone()
    if row:
        return False

    return True


def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE char_chocobos RENAME COLUMN colour to color;")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
