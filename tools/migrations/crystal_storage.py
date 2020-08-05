import array
import mysql.connector

def migration_name():
	return "Adding crystal storage columns to char_points table"

def check_preconditions(cur):
	return;

def needs_to_run(cur):
	# Ensure crystal columns exist in char_points
	cur.execute("SHOW COLUMNS FROM char_points LIKE 'fire_crystals'")
	if not cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("ALTER TABLE char_points \
		ADD COLUMN `fire_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `ice_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `wind_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `earth_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `lightning_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `water_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `light_crystals` smallint(5) unsigned NOT NULL DEFAULT 0, \
		ADD COLUMN `dark_crystals` smallint(5) unsigned NOT NULL DEFAULT 0;")
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))