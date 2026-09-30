import mariadb


def migration_name():
    return "Adding client_addr and udp_port_slot columns to accounts_profile table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM accounts_profile LIKE 'udp_port_slot'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE accounts_profile \
        ADD COLUMN IF NOT EXISTS `client_addr` varchar(45) NOT NULL DEFAULT '' AFTER `refreshed`, \
        ADD COLUMN IF NOT EXISTS `udp_port_slot` smallint(5) unsigned NOT NULL DEFAULT '0' AFTER `client_addr`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
