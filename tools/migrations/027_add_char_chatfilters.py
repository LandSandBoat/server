import mariadb


def migration_name():
    return "Adding chatfilters column to chars table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure chatfilters column exists in chars
    cur.execute("SHOW COLUMNS FROM chars LIKE 'chatfilters'")
    old_chatfilters = cur.fetchone();

    # Check for new chat filters...
    cur.execute("SHOW COLUMNS FROM chars LIKE 'chatfilters_1'")
    new_chatfilters = cur.fetchone()

    if not old_chatfilters and not new_chatfilters:
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `chars` \
        ADD COLUMN `chatfilters` bigint(20) unsigned NOT NULL DEFAULT '0' AFTER `nnameflags`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
