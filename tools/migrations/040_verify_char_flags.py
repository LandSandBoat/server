import mariadb


def migration_name():
    return "Verifying char_flags row count is equal to chars"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure chatfilters column exists in chars
    cur.execute("SELECT COUNT(*) as num_chars FROM chars;")
    char_count = cur.fetchone()[0]

    cur.execute("SELECT COUNT(*) as num_char_flags FROM char_flags;")
    char_flags_count = cur.fetchone()[0]

    if char_flags_count < char_count:
        return True
    return False


def migrate(cur, db):
    try:
        # Add default row for each character into new char_flags table, on duplicate do nothing.
        cur.execute("INSERT INTO char_flags (charid) SELECT charid FROM chars ON DUPLICATE KEY UPDATE char_flags.disconnecting = char_flags.disconnecting;");
        print("If this (char_flags) migration is running repeatedly, there is probably a bug somewhere. Please report this.")
        db.commit()

    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
