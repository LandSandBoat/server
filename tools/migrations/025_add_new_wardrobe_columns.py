import mariadb


def migration_name():
    return "Adding columns wardrobe5, wardrobe6, wardrobe7, and wardrobe8 to char_storage table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM char_storage LIKE 'wardrobe5'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_storage \
        ADD COLUMN `wardrobe5` tinyint(2) unsigned NOT NULL DEFAULT '80', \
        ADD COLUMN `wardrobe6` tinyint(2) unsigned NOT NULL DEFAULT '80', \
        ADD COLUMN `wardrobe7` tinyint(2) unsigned NOT NULL DEFAULT '80', \
        ADD COLUMN `wardrobe8` tinyint(2) unsigned NOT NULL DEFAULT '80' \
        ;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
