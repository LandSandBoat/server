import mariadb


def migration_name():
    return "Add idx_ah_active and idx_ah_history to auction_house, drop itemid index"


def check_preconditions(cur):
    return


def _existing_indexes(cur):
    cur.execute("SHOW INDEX FROM auction_house")
    names = set()
    for row in cur.fetchall():
        names.add(row[2])
    return names


def needs_to_run(cur):
    names = _existing_indexes(cur)
    if "idx_ah_active" not in names or "idx_ah_history" not in names:
        return True
    if "itemid" in names:
        return True
    return False


def migrate(cur, db):
    try:
        names = _existing_indexes(cur)
        if "idx_ah_active" not in names:
            cur.execute("CREATE INDEX idx_ah_active ON auction_house (buyer_name, itemid, stack, price)")
        if "idx_ah_history" not in names:
            cur.execute("CREATE INDEX idx_ah_history ON auction_house (itemid, stack, sell_date)")
        if "itemid" in names:
            cur.execute("ALTER TABLE auction_house DROP INDEX itemid")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
