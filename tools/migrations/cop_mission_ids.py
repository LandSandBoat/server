import array
import mysql.connector

mission_map = {
    0  : 101,
    1  : 110,
    2  : 118,
    3  : 128,
    5  : 138,
    15 : 218,
    16 : 228,
    17 : 238,
    18 : 248,
    19 : 257,
    20 : 258,
    27 : 318,
    28 : 325,
    29 : 335,
    30 : 341,
    31 : 350,
    32 : 358,
    33 : 368,
    40 : 418,
    41 : 428,
    42 : 438,
    43 : 448,
    52 : 518,
    54 : 530,
    55 : 543,
    56 : 552,
    57 : 560,
    58 : 568,
    60 : 578,
    65 : 618,
    66 : 628,
    67 : 638,
    68 : 648,
    77 : 718,
    78 : 728,
    80 : 738,
    81 : 748,
    82 : 758,
    87 : 800,
    90 : 818,
    91 : 828,
    92 : 840,
    94 : 850,
}

def migration_name():
    return "Converting CoP mission IDs"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    # Ensure old mission IDs are still being used
    cur.execute("SELECT COUNT(*) FROM chars WHERE LENGTH(missions) < 1050;")
    row = cur.fetchone()[0]
    if row and row > 0:
        return True
    cur.execute("SELECT missions FROM chars WHERE missions IS NOT NULL AND LENGTH(missions) = 1050 LIMIT 1;")
    row = cur.fetchone()
    if row:
        row = bytearray(row[0])
        currentMissionID = int.from_bytes(row[420:422], byteorder='little')
        if currentMissionID < 101:
            return True
    return False


def migrate(cur, db):
    efile = open('migration_errors.log', 'a')
    cur.execute("SELECT charid FROM chars WHERE LENGTH(missions) = 1050;")
    rows = cur.fetchall()
    for charid in rows:
        charid = charid[0]
        cur.execute("SELECT missions FROM chars WHERE charid = {}".format(charid))
        row = cur.fetchone()
        if row:
            try:
                row = bytearray(row[0])
                currentMissionID = int.from_bytes(row[420:422], byteorder='little')
                if currentMissionID not in mission_map:
                    if currentMissionID > 100:
                        continue
                    efile.write('[cop_mission_ids] Invalid CoP mission for charid: ' + str(charid) + ', Mission ID: ' + str(currentMissionID) + '.')
                    continue
                newMissionID = mission_map[currentMissionID]
                row[420:422] = newMissionID.to_bytes(2, 'little')
                try:
                    cur.execute("UPDATE chars SET missions = %s WHERE charid = %s", (row, charid))
                    db.commit()
                except mysql.connector.Error as err:
                    print("Something went wrong: {}".format(err))
            except:
                efile.write('[cop_mission_ids] Error reading missions in chars table for charid: ' + str(charid) + '\n')
    db.commit()