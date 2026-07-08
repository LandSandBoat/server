import mariadb


def migration_name():
    return "Adding alter_ego_points column to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'alter_ego_points'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
                ADD COLUMN `alter_ego_points` smallint(5) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
