import mariadb


def migration_name():
    return "Adding accounts.login as a key."


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Check if the key already exists
    cur.execute(
        "SELECT DISTINCT TABLE_NAME, INDEX_NAME FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'accounts' AND INDEX_NAME = 'login';"
    )
    if cur.fetchone():
        return False
    return True


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE accounts ADD KEY login (login);"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
