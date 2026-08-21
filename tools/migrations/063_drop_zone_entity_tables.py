import mariadb

DROPPED_TABLES = [
    "mob_spawn_slots",
    "zonelines",
]

DROPPED_COLUMNS = [
    "zonetype",
    "music_day",
    "music_night",
    "battlesolo",
    "battlemulti",
    "restriction",
    "tax",
    "misc",
]


def migration_name():
    return "Drop zone entity tables and zone_settings columns the YAML files replaced"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    for table in DROPPED_TABLES:
        cur.execute(f"SHOW TABLES LIKE '{table}';")
        if cur.fetchone():
            return True

    for column in DROPPED_COLUMNS:
        cur.execute(f"SHOW COLUMNS FROM `zone_settings` LIKE '{column}';")
        if cur.fetchone():
            return True

    return False


def migrate(cur, db):
    try:
        for table in DROPPED_TABLES:
            cur.execute(f"DROP TABLE IF EXISTS `{table}`;")

        for column in DROPPED_COLUMNS:
            cur.execute(f"SHOW COLUMNS FROM `zone_settings` LIKE '{column}';")
            if cur.fetchone():
                cur.execute(f"ALTER TABLE `zone_settings` DROP COLUMN `{column}`;")

        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
