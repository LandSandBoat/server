import mariadb


def migration_name():
    return "Adding pos_prevzonelineid column to chars table"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure pos_prevzonelineid column exists in chars
    cur.execute("SHOW COLUMNS FROM chars LIKE 'pos_prevzonelineid'")

    if cur.fetchone():
        return False

    return True

def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `chars` \
            ADD COLUMN `pos_prevzonelineid` int(10) unsigned NOT NULL DEFAULT 0 AFTER `pos_prevzone`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
