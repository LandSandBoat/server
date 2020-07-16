import array
import mysql.connector

def migration_name():
    return "Adding eminence column for chars"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure mission blob hasn't already been expanded
    cur.execute("SHOW COLUMNS FROM chars LIKE 'eminence';")

    row = cur.fetchone()
    if row:
        return False

    return True

def migrate(cur, db):
    cur.execute("ALTER TABLE `chars` ADD COLUMN eminence blob;")
    db.commit()