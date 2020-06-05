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
    cur.execute("SELECT missions FROM chars WHERE missions IS NOT NULL LIMIT 1;")

    row = cur.fetchone()
    if row:
        row = bytearray(row[0])
        currentMissionID = int.from_bytes(row[420:422], byteorder='little')
        if currentMissionID < 101:
            return True

    return False


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
                currentMissionID = int.from_bytes(row[420:422], byteorder='little')
                newMissionID = mission_map[currentMissionID]
                row[420:422] = newMissionID.to_bytes(2, 'little')
            try:
                cur.execute("UPDATE chars SET missions = %s WHERE charid = %s", (row, charid))
                db.commit()
            except mysql.connector.Error as err:
                print("Something went wrong: {}".format(err))                
    db.commit()