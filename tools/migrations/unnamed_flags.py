import mysql.connector

def migration_name():
    return "Display Head and New Player"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # ensure nnameflags does not exist
    cur.execute("SHOW COLUMNS FROM `chars` LIKE 'nnameflags';")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("ALTER TABLE `chars` ADD COLUMN `nnameflags` int(10) unsigned NOT NULL DEFAULT '0';")
        cur.execute("UPDATE `chars` o, `chars` n SET o.`nnameflags` = (CASE WHEN n.isnewplayer THEN 0x0 ELSE 0x04 END) WHERE o.charid = n.charid;")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))