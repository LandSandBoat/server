import mysql.connector

def migration_name():
    return "Adding IP Exceptions Table"

def check_preconditions(cur):
        return

def needs_to_run(cur):
    # Ensure IP_Exceptions table exists
    cur.execute("SHOW TABLES LIKE 'ip_exceptions';")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("CREATE TABLE ip_exceptions( \
                    accid int(10) unsigned NOT NULL DEFAULT '0', \
                    exception datetime NOT NULL DEFAULT '0000-00-00 00:00:00', \
                    comment varchar(512) DEFAULT NULL, \
                    PRIMARY KEY ( accid ));")
        db.commit()

    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
