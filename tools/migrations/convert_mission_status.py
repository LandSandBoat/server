import array
import mysql.connector

def migration_name():
    return "Converting mission status"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SELECT COUNT(*) FROM char_vars INNER JOIN chars ON char_vars.varname = 'missionStatus' AND char_vars.charid = chars.charid AND chars.missions IS NOT NULL;")
    row = cur.fetchone()[0]
    if row and row > 0:
        return True
    return False

def migrate(cur, db):
    cur.execute("SELECT chars.charid, chars.nation, chars.missions, char_vars.value FROM chars INNER JOIN char_vars ON char_vars.varname = 'missionStatus' AND char_vars.charid = chars.charid AND chars.missions IS NOT NULL;")
    rows = cur.fetchall()
    for row in rows:
        charid = row[0]
        nation = row[1]
        missions = bytearray(row[2])
        mission_status = row[3]
        nation_status_index = (nation * 70) + 4
        missions[nation_status_index:nation_status_index+2] = mission_status.to_bytes(2, 'little')
        try:
            cur.execute("UPDATE chars SET missions = %s WHERE charid = %s", (missions, charid))
            cur.execute("DELETE char_vars FROM char_vars WHERE charid = {} AND varname = 'missionStatus';".format(charid))
            db.commit()
        except mysql.connector.Error as err:
            print("Something went wrong: {}".format(err))
