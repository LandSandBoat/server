import mariadb


def migration_name():
    return "Converting DB engine for tables from MyISAM to InnoDB"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute(
        "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'xidb' AND ENGINE = 'MyISAM' AND \
                (TABLE_NAME LIKE 'char' OR TABLE_NAME LIKE 'account' OR TABLE_NAME LIKE 'audit' OR TABLE_NAME = 'delivery_box' OR \
                TABLE_NAME = 'auction_house' OR TABLE_NAME = 'conquest_system' OR TABLE_NAME = 'unity_system' OR \
                TABLE_NAME = 'server_variables' OR TABLE_NAME = 'linkshells' OR TABLE_NAME = 'bcnm_info')"
    )
    if cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'xidb' AND ENGINE = 'MyISAM' AND \
                    (TABLE_NAME LIKE 'char' OR TABLE_NAME LIKE 'account' OR TABLE_NAME LIKE 'audit' OR TABLE_NAME = 'delivery_box' OR \
                    TABLE_NAME = 'auction_house' OR TABLE_NAME = 'conquest_system' OR TABLE_NAME = 'unity_system' OR \
                    TABLE_NAME = 'server_variables' OR TABLE_NAME = 'linkshells' OR TABLE_NAME = 'bcnm_info')"
        )
        for r in cur.fetchall():
            cur.execute("ALTER TABLE `{}` ROW_FORMAT=DYNAMIC;".format(r[0]))
            cur.execute("ALTER TABLE `{}` ENGINE=InnoDB;".format(r[0]))
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
