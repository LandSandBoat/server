import mariadb


def migration_name():
    return "Store help_desk messages and responses as blobs"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute(
        "SHOW COLUMNS FROM help_desk WHERE Field IN ('message', 'response') AND Type NOT LIKE '%blob%';"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE help_desk MODIFY message BLOB NOT NULL, MODIFY response BLOB DEFAULT NULL;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
