import array
import mysql.connector

def migration_name():
    return "Pad mission log"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure mission blob hasn't already been expanded
    cur.execute("SELECT COUNT(*) FROM chars WHERE LENGTH(missions) < 990;")
    row = cur.fetchone()[0]
    if not row or row == 0:
        return False
    return True

def migrate(cur, db):
    efile = open('migration_errors.log', 'a')
    cur.execute("SELECT charid FROM chars WHERE LENGTH(missions) < 990;")
    ids = cur.fetchall()
    for charid in ids:
        try:
            charid = charid[0]
            cur.execute("SELECT missions FROM chars WHERE charid = {}".format(charid))
            missions = bytearray(cur.fetchone()[0])
            while len(missions) < 990:
                missions.append(0)
            try:
                cur.execute("UPDATE chars SET missions = %s WHERE charid = %s", (missions, charid))
                db.commit()
            except mysql.connector.Error as err:
                print("Something went wrong: {}".format(err))
        except:
            efile.write('[extend_mission_log] Error reading missions in chars table for charid: ' + str(charid) + '\n')
    db.commit()