import array
import mysql.connector

def migration_name():
	return "Adding daily_tally column to char_points table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	# Ensure daily_tally column exists in char_points
	cur.execute("SHOW COLUMNS FROM char_points LIKE 'daily_tally'")
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("ALTER TABLE char_points \
		ADD COLUMN `daily_tally` int(10) signed NOT NULL DEFAULT '-1';")
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))