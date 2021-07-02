import mysql.connector

def migration_name():
    return "Search comment and language columns"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'chars' AND COLUMN_NAME = 'languages';")
    row = cur.fetchall()[0][0]
    return row == "tinyint"

def migrate(cur, db):
    try:
        cur.execute("""ALTER TABLE `chars`
	        ADD COLUMN `languages` TINYINT(1) UNSIGNED NULL DEFAULT '0' AFTER `gmlevel`;""")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
