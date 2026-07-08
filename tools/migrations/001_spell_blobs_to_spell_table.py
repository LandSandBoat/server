import mariadb
import re

hex2bin = {
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "8": "1000",
    "9": "1001",
    "A": "1010",
    "B": "1011",
    "C": "1100",
    "D": "1101",
    "E": "1110",
    "F": "1111",
}


def blob_to_binary(blob):
    # Split hex string into pairs of two
    split_spells = re.findall("..", blob)

    for index, item in enumerate(split_spells):
        # reverse each pair of hexes
        reversed_hex = item[::-1]

        # replace hex val with binary value
        split_spells[index] = ""
        for hex in reversed_hex:
            # Reverse binary val
            split_spells[index] += hex2bin[hex][::-1]

    # print(split_spells)

    # Join everything together in one big 1/0 string
    return "".join(split_spells)


def migration_name():
    return "Spell blobs to spell table"


def check_preconditions(cur):
    cur.execute("SHOW TABLES LIKE 'char_spells';")

    if not cur.fetchone():
        raise Exception(
            "char_spells table does not exist. Please run sql/char_spells.sql"
        )


def needs_to_run(cur):
    # ensure char_spells table is empty
    cur.execute("SELECT count(*) FROM char_spells")

    row = cur.fetchone()
    if row[0] != 0:
        return False

    # ensure spells column exists
    cur.execute("SHOW COLUMNS FROM chars LIKE 'spells';")

    if not cur.fetchone():
        return False

    return True


def migrate(cur, db):

    try:
        spellLimit = 1024
        cur.execute("SELECT charid, HEX(spells) as spells FROM chars")
        rows = cur.fetchall()

        for row in rows:
            charId = row[0]
            spells = row[1]

            if spells != None and spells != "":
                print("Migrating charid: %d" % charId)

                spellId = 0

                binary_spells = blob_to_binary(spells)

                for bit in binary_spells:
                    if bit == "1":
                        if spellId >= spellLimit:
                            print(
                                "Going over spell limit of %d, not adding %d"
                                % (spellLimit, spellId)
                            )
                        else:
                            cur.execute(
                                "INSERT IGNORE INTO char_spells VALUES (%s, %s);",
                                (charId, spellId),
                            )
                            # print("Added spell %d" % spellId)

                    spellId = spellId + 1

                print(" [OK]")

            else:
                print("Charid %d has no spells, skipping" % charId)

        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
