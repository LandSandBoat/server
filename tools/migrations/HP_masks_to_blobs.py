import array
import mysql.connector

def migration_name():
    return "HP Masks to BLOB Data"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure homepoint bitmasks exist in char_vars
    cur.execute("SELECT value FROM char_vars WHERE varname LIKE('HpTeleportMask%') LIMIT 1;")

    if not cur.fetchone():
        return False

    return True

def migrate(cur, db):

    masks = [0,0,0,0]
    minID = 0
    maxID = 0

    cur.execute("SELECT MIN(charid), MAX(charid) FROM chars;")

    rows = cur.fetchall()

    for ids in rows:

        minID = ids[0]
        maxID = ids[1]

        for charid in range(minID, maxID + 1):
            y = 0
            for x in range(1,5):
                left = 0
                right = 0
                cur.execute("SELECT value FROM char_vars WHERE charid = {} AND varname = 'HpTeleportMask{}a'".format(charid, x))
                rows = cur.fetchall()
                for row in rows:
                    left = row[0]
                cur.execute("SELECT value FROM char_vars WHERE charid = {} AND varname = 'HpTeleportMask{}b'".format(charid, x))
                rows = cur.fetchall()
                for row in rows:
                    right = row[0]

                masks[x-1] = (left << 16) | right

            hpData = array.array('I', masks).tobytes()
            try:
                cur.execute("UPDATE char_unlocks SET homepoints = %s WHERE charid = %s", (hpData, charid))
                db.commit()
            except mysql.connector.Error as err:
                print("Something went wrong: {}".format(err))                

    cur.execute("DELETE FROM char_vars WHERE varname LIKE('HpTeleportMask%')")
    db.commit()