import array
import mysql.connector

def migration_name():
	return "Converting DB engine for all tables from MyISAM to InnoDB"

def check_preconditions(cur):
	return

def needs_to_run(cur):
	cur.execute("SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'xidb' AND ENGINE = 'MyISAM' LIMIT 1")
	if cur.fetchone():
		return True
	return False

def migrate(cur, db):
	try:
		cur.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'xidb' AND ENGINE = 'MyISAM'") 
		for r in cur.fetchall():
			cur.execute('ALTER TABLE `{}` ROW_FORMAT=DYNAMIC;'.format(r[0]))
			cur.execute('ALTER TABLE `{}` ENGINE=InnoDB;'.format(r[0]))
		db.commit()
	except mysql.connector.Error as err:
		print("Something went wrong: {}".format(err))
