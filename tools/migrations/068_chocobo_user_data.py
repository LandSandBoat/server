import mariadb


def migration_name():
    return "Moving char_pet.field_chocobo into a chocobo_user_data blob"


def check_preconditions(cur):
    return


def has_column(cur, name):
    cur.execute("SHOW COLUMNS FROM char_pet LIKE %s", (name,))
    return cur.fetchone() is not None


def needs_to_run(cur):
    return not has_column(cur, "chocobo_user_data") or has_column(cur, "field_chocobo")


# The blob starts with the field chocobo as a little-endian u32; see ChocoboUserData_t.
def with_field_chocobo(blob, field_chocobo):
    data = bytearray(blob or b"")
    if len(data) < 4:
        data.extend(bytes(4 - len(data)))
    data[0:4] = field_chocobo.to_bytes(4, "little")
    return bytes(data)


def migrate(cur, db):
    try:
        if not has_column(cur, "chocobo_user_data"):
            cur.execute("ALTER TABLE char_pet ADD COLUMN `chocobo_user_data` blob;")

        if has_column(cur, "field_chocobo"):
            cur.execute("SELECT charid, field_chocobo, chocobo_user_data FROM char_pet WHERE field_chocobo != 0")
            for charid, field_chocobo, blob in cur.fetchall():
                cur.execute(
                    "UPDATE char_pet SET chocobo_user_data = %s WHERE charid = %s",
                    (with_field_chocobo(blob, field_chocobo), charid),
                )

            cur.execute("ALTER TABLE char_pet DROP COLUMN `field_chocobo`;")

        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
