import array
import mysql.connector

def migration_name():
    return "Changing Char Unlock Table Columns"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure homepoint bitmasks exist in char_vars
    cur.execute("SHOW COLUMNS FROM char_unlocks LIKE 'sandoria_supply'")

    if not cur.fetchone():
        return False

    return True

def migrate(cur, db):

    try:
        cur.execute("ALTER TABLE char_unlocks CHANGE sandoria_supply  outpost_sandy   int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks CHANGE bastok_supply    outpost_bastok  int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks CHANGE windurst_supply  outpost_windy   int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks CHANGE past_sandoria_tp campaign_sandy  int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks CHANGE past_bastok_tp   campaign_bastok int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks CHANGE past_windurst_tp campaign_windy  int(10) unsigned NOT NULL DEFAULT 0;")
        cur.execute("ALTER TABLE char_unlocks ADD COLUMN survivals BLOB DEFAULT NULL;")
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))