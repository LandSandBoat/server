def migration_name():
    return "Adding timestamp column for chars"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM chars LIKE 'lastupdate';")

    row = cur.fetchone()
    if row:
        return False

    return True


def migrate(cur, db):
    cur.execute(
        "ALTER TABLE `chars` ADD COLUMN lastupdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;"
    )
    db.commit()
