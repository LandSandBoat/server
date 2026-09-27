import mariadb


def migration_name():
    return "Adding field_chocobo column to char_pet table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # 068 moves field_chocobo into chocobo_user_data.
    cur.execute("SHOW COLUMNS FROM char_pet LIKE 'chocobo_user_data'")
    if cur.fetchone():
        return False

    cur.execute("SHOW COLUMNS FROM char_pet LIKE 'field_chocobo'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_pet \
        ADD COLUMN `field_chocobo` int(11) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
