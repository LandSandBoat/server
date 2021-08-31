import array
import mysql.connector

def migration_name():
	return "Adding broken column to linkshells table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	# Ensure broken column exists in linkshells
	cur.execute("SHOW COLUMNS FROM linkshells LIKE 'broken'")
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("ALTER TABLE linkshells ADD COLUMN `broken` tinyint(1) unsigned NOT NULL DEFAULT 0;")
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))