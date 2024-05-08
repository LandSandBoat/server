import mariadb


def migration_name():
    return "Adding settings, chatfilters1, chatfilters2 column to chars table and removing obsolete fields (nameflags, nnameflags)"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure chatfilters column exists in chars
    cur.execute("SHOW COLUMNS FROM char_stats LIKE 'nameflags'")
    nameflags = cur.fetchone()

    cur.execute("SHOW COLUMNS FROM chars LIKE 'settings'")
    settings = cur.fetchone()

    if nameflags and not settings:
        return True
    return False


def migrate(cur, db):
    try:
        # Delete old nameflags/chat filters because they cannot be converted
        cur.execute(
            "ALTER TABLE `chars` \
        DROP COLUMN `nnameflags`, \
        DROP COLUMN `chatfilters`;"
        )
        db.commit()

        cur.execute(
            "ALTER TABLE `char_stats` \
        DROP COLUMN `nameflags`;"
        )
        db.commit()

        # add new columns
        cur.execute(
            "ALTER TABLE `chars` \
        ADD COLUMN `settings` bigint(20) unsigned NOT NULL DEFAULT '0' AFTER `isstylelocked`;"
        )
        db.commit()

        cur.execute(
            "ALTER TABLE `chars` \
        ADD COLUMN `chatfilters_1` bigint(20) unsigned NOT NULL DEFAULT '0' AFTER `settings`;"
        )
        db.commit()

        cur.execute(
            "ALTER TABLE `chars` \
        ADD COLUMN `chatfilters_2` bigint(20) unsigned NOT NULL DEFAULT '0' AFTER `chatfilters_1`;"
        )
        db.commit()

        # Add default row for each character into new char_flags table, on duplicate do nothing.
        cur.execute("INSERT INTO char_flags (charid) SELECT charid FROM chars ON DUPLICATE KEY UPDATE char_flags.disconnecting = char_flags.disconnecting;");
        db.commit()

    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
