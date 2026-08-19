import mariadb


def migration_name():
    return "Adding buyer charid to auction_house"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("show columns from auction_house where field = 'buyer';")
    if cur.fetchone():
        return False
    return True


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE auction_house "
            "ADD COLUMN buyer int(10) unsigned NOT NULL DEFAULT 0 AFTER price, "
            "ADD INDEX buyer (buyer);"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
