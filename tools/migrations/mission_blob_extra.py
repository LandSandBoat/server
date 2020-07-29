import array
import mysql.connector

def migration_name():
    return "Adding extra data to mission blob"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure mission blob hasn't already been expanded
    cur.execute("SELECT COUNT(*) FROM chars WHERE LENGTH(missions) < 1050;")
    row = cur.fetchone()[0]
    if not row or row == 0:
        return False
    return True

def migrate(cur, db):
    efile = open('migration_errors.log', 'a')
    cur.execute("SELECT charid FROM chars WHERE LENGTH(missions) < 1050;")
    rows = cur.fetchall()
    for charid in rows:
        charid = charid[0]
        cur.execute("SELECT missions FROM chars WHERE charid = {}".format(charid))
        row = cur.fetchone()
        if row:
            try:
                row = bytearray(row[0])
                logEx = bytearray(b'\x00\x00\x00\x00')
                pos = 2
                for _ in range(1,16):
                    row[pos:pos] = logEx
                    pos += 70
                try:
                    cur.execute("UPDATE chars SET missions = %s WHERE charid = %s", (row, charid))
                    db.commit()
                except mysql.connector.Error as err:
                    print("Something went wrong: {}".format(err))
            except:
                efile.write('[mission_blob_extra] Error reading missions in chars table for charid: ' + str(charid) + '\n')
    db.commit()