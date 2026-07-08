def migration_name():
    return "Adding Pet Level column for char_stats"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM char_stats LIKE 'pet_level';")

    row = cur.fetchone()
    if row:
        return False

    return True


def migrate(cur, db):
    cur.execute(
        "ALTER TABLE `char_stats` ADD COLUMN `pet_level` smallint(3) unsigned NOT NULL DEFAULT '0';"
    )
    db.commit()
