#!/usr/bin/python3
import mysql.connector
from mysql.connector import Error, errorcode
import re

prizes = {
    1:"festiveMoogleNomadCap",
    2:"festiveMoogleMoogleCap",
    3:"festiveMoogleMoogleRod",
    4:"festiveMoogleHarpsichord",
    5:"festiveMooglestuffedChocobo",
    6:"festiveMoogleTidalTalisman",
    7:"festiveMoogleDestrierBeret",
    8:"festiveMoogleChocoboShirt",
}
credentials = {}
db = cur = database = host = port = login = password = None

def connect():
    print("Loading conf/map.conf")
    # Grab mysql credentials
    filename = "../conf/map.conf"

    global credentials, db, cur, database, host, port, login, password

    with open(filename) as f:
        while True:
            line = f.readline()
            if not line: break
            match = re.match(r"(mysql_\w+):\s+(\S+)", line)
            if match:
                credentials[match.group(1)] = match.group(2)

    database = credentials["mysql_database"]
    host = credentials["mysql_host"]
    port = int(credentials["mysql_port"])
    login = credentials["mysql_login"]
    password = credentials["mysql_password"]

    try:
        db = mysql.connector.connect(host=host,
                user=login,
                passwd=password,
                db=database,
                port=port,
                use_pure=True)
        cur = db.cursor()
    except mysql.connector.Error as err:
        print(err)
        close()
    else:
        print("Connected to database: " + database)

def close():
    if db:
        print("Closing connection...")
        cur.close()
        db.close()
    input("Press Enter")

def all_characters(cur):
    print("Items Available:\
    \n1) Nomad Cap\
    \n2) Moogle Cap\
    \n3) Moogle Rod\
    \n4) Harpsichord\
    \n5) Stuffed Chocobo\
    \n6) Tidal Talisman\
    \n7) Destrier Beret\
    \n8) Chocobo Shirt\
    \n")
    while True:
        try:
            prize = int(input("Enter prize to give: "))
        except ValueError:
            return
        else:
            if 0 < prize < 9:
                minID = 0
                maxID = 0

                cur.execute("SELECT MIN(charid), MAX(charid) FROM chars;")
                rows = cur.fetchall()

                for ids in rows:
                    minID = ids[0]
                    maxID = ids[1]

                    for charid in range(minID, maxID + 1):
                        cur.execute("INSERT IGNORE INTO char_vars (charid, varname, value) VALUES (%s, %s, %s)", (charid, prizes[prize], 1))
                    print("Prizes distributed!")
                    return
            else:
                print("Out of range.")

def single_character(cur):
    name = input("Enter name of character: ")
    cur.execute("SELECT charid FROM chars WHERE charname = '{}' LIMIT 1;".format(name))
    row = cur.fetchone()
    if row:
        print("Items Available:\
            \n1) Nomad Cap\
            \n2) Moogle Cap\
            \n3) Moogle Rod\
            \n4) Harpsichord\
            \n5) Stuffed Chocobo\
            \n6) Tidal Talisman\
            \n7) Destrier Beret\
            \n8) Chocobo Shirt\
            \n")
        while True:
            try:
                prize = int(input("Enter prize to give: "))
            except ValueError:
                break
            else:
                if 0 < prize < 9:
                    cur.execute("INSERT IGNORE INTO char_vars (charid, varname, value) VALUES (%s, %s, %s)", (row[0], prizes[prize], 1))
                    print("Prize distributed!")
                    return
                else:
                    print("Out of range.")
    else:
        print("Invalid character.")

def main():
    connect()
    print("This Python script allows to give a mog item to the character of your choice\
    ")
    print("How do you want to assign items?\
    \n 1) Single Character\
    \n 2) All Characters")
    choice = int(input("Enter a selection (1-2): "))
    if choice == 1:
        single_character(cur)
    elif choice == 2:
        all_characters(cur)
    close()


if __name__ == "__main__":
    main()

