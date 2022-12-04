def migration_name():
    return "Adding fame_holiday column to char_profile"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure column doesn't already exist.
    cur.execute("SHOW COLUMNS FROM char_profile LIKE 'fame_holiday';")

    row = cur.fetchone()
    if row:
        return False

    return True


def migrate(cur, db):
    cur.execute(
        "ALTER TABLE `char_profile` ADD COLUMN IF NOT EXISTS `fame_holiday` smallint(5) unsigned NOT NULL DEFAULT 0 AFTER `fame_adoulin`;"
    )
    db.commit()
