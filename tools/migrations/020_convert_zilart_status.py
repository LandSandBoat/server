import mariadb


def migration_name():
    return "Converting zilart status"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute(
        "SELECT COUNT(*) FROM char_vars INNER JOIN chars ON char_vars.varname = 'ZilartStatus' AND char_vars.charid = chars.charid AND chars.missions IS NOT NULL;"
    )
    row = cur.fetchone()[0]
    if row and row > 0:
        return True
    return False


def migrate(cur, db):
    cur.execute(
        "SELECT chars.charid, chars.missions, char_vars.value FROM chars INNER JOIN char_vars ON char_vars.varname = 'ZilartStatus' AND char_vars.charid = chars.charid AND chars.missions IS NOT NULL;"
    )
    rows = cur.fetchall()
    for row in rows:
        charid = row[0]
        missions = bytearray(row[1])
        zilart_status = row[2]
        missions[214:216] = zilart_status.to_bytes(2, "little")
        try:
            cur.execute(
                "UPDATE chars SET missions = %s WHERE charid = %s",
                (bytes(missions), charid),
            )
            cur.execute(
                "DELETE char_vars FROM char_vars WHERE charid = {} AND varname = 'ZilartStatus';".format(
                    charid
                )
            )
            db.commit()
        except mariadb.Error as err:
            print("Something went wrong: {}".format(err))
