import mariadb


def migration_name():
    return "Expanding mhflag column in char_stats table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("DESCRIBE char_stats mhflag;")
    return cur.fetchone()[1] != "smallint(4) unsigned"


def migrate(cur, db):
    try:
        # `mhflag` smallint(4) unsigned NOT NULL DEFAULT '0',
        cur.execute(
            "ALTER TABLE char_stats \
                MODIFY mhflag smallint(4) unsigned NOT NULL DEFAULT '0';"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
