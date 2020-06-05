import array
import mysql.connector

def migration_name():
    return "Adding extra data to mission blob"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure mission blob hasn't already been expanded
    cur.execute("SELECT missions FROM chars WHERE missions IS NOT NULL LIMIT 1;")

    row = cur.fetchone()
    if not row or len(row[0]) == 1050:
        return False

    return True

def migrate(cur, db):
    minID = 0
    maxID = 0

    cur.execute("SELECT MIN(charid), MAX(charid) FROM chars;")

    rows = cur.fetchall()

    for ids in rows:

        minID = ids[0]
        maxID = ids[1]

        for charid in range(minID, maxID + 1):
            cur.execute("SELECT missions FROM chars WHERE charid = {} AND missions IS NOT NULL".format(charid))
            row = cur.fetchone()
            if row:
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
    db.commit()