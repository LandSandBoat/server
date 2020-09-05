import array
import mysql.connector

def migration_name():
	return "Adding timecreated column to chars table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	# Ensure timecreated column exists in chars
	cur.execute("SHOW COLUMNS FROM chars LIKE 'timecreated'")
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("ALTER TABLE chars \
		ADD COLUMN `timecreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;")
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))