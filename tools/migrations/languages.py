import mysql.connector

def migration_name():
    return "Search comment and language columns"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM chars LIKE 'languages'")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("""ALTER TABLE `chars`
	        ADD COLUMN `languages` TINYINT(1) UNSIGNED NULL DEFAULT '0' AFTER `gmlevel`;""")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
