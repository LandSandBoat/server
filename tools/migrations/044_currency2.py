import mariadb


def migration_name():
    return "Adding domain invasion, mog segments, gallimaufry, is_accolades columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure waypoints column exists in char_unlocks
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'domain_points'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
                ADD COLUMN `domain_points` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `domain_points_daily` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `mog_segments` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `gallimaufry` int(10) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `is_accolades` smallint(5) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
