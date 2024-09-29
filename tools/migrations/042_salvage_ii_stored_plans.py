import mariadb


def migration_name():
    return "Adding Salvage II stored plan columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure stored plan columns exist in char_points
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'bloodshed_plans'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
                ADD COLUMN `bloodshed_plans` smallint(5) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `umbrage_plans` smallint(5) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `ritualistic_plans` smallint(5) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `tutelary_plans` smallint(5) unsigned NOT NULL DEFAULT 0, \
                ADD COLUMN `primacy_plans` smallint(5) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
