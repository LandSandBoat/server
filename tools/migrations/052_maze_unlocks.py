import mariadb


def migration_name():
    return "Adding maze_vouchers and maze_runes columns to char_unlocks table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'maze_vouchers'")
    if cur.fetchone():
        return False

    return True


def migrate(cur, db):
    try:
        cur.execute(
            """
            ALTER TABLE `char_unlocks`
                ADD COLUMN `maze_vouchers` BLOB DEFAULT NULL AFTER `unique_event`,
                ADD COLUMN `maze_runes`    BLOB DEFAULT NULL AFTER `maze_vouchers`;
            """
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
