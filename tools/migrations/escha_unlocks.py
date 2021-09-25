import array
import mysql.connector

def migration_name():
	return "Adding eschan_portals and vorseals columns to char_unlocks table"

def check_preconditions(cur):
	return

def needs_to_run(cur):
    # Ensure escha_portal column exists in char_profile
	cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'eschan_portals'")
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("ALTER TABLE char_unlocks ADD COLUMN `eschan_portals` BLOB DEFAULT NULL;")
		cur.execute("ALTER TABLE char_unlocks ADD COLUMN `vorseals` BLOB DEFAULT NULL;")
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))