import mariadb


def migration_name():
    return "Adding last_logout column to chars table, muted column to char_flags table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM chars LIKE 'last_logout'")
    last_logout = cur.fetchone()
    cur.execute("SHOW COLUMNS FROM char_flags LIKE 'muted'")
    muted = cur.fetchone()

    if not last_logout or not muted:
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            """
            ALTER TABLE `chars`
                ADD COLUMN `last_logout` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `timecreated`;
            """
        )
        db.commit()

        cur.execute(
            """
            ALTER TABLE `char_flags`
                ADD COLUMN `muted` boolean NOT NULL DEFAULT FALSE AFTER `gmHiddenEnabled`;
            """
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
