import mysql.connector

def migration_name():
    return "Adding char_chocobos table"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SHOW TABLES LIKE 'char_chocobos'")
    if not cur.fetchone():
        return True
    return False

def migrate(cur, db):
    try:
        cur.execute("""
            CREATE TABLE `char_chocobos` (
            `charid` int unsigned NOT NULL,
            `first_name` varchar(15) NOT NULL,
            `last_name` varchar(15) NOT NULL,
            `sex` boolean NOT NULL,
            `created` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            `last_update_age` tinyint unsigned NOT NULL,
            `stage` tinyint unsigned NOT NULL,
            `location` tinyint unsigned NOT NULL,
            `colour` tinyint unsigned NOT NULL,
            `dominant_gene` tinyint unsigned NOT NULL,
            `recessive_gene` tinyint unsigned NOT NULL,
            `strength` tinyint unsigned NOT NULL,
            `endurance` tinyint unsigned NOT NULL,
            `discernment` tinyint unsigned NOT NULL,
            `receptivity` tinyint unsigned NOT NULL,
            `affection` tinyint unsigned NOT NULL,
            `energy` tinyint unsigned NOT NULL,
            `satisfaction` tinyint unsigned NOT NULL,
            `conditions` int unsigned NOT NULL,
            `ability1` tinyint unsigned NOT NULL,
            `ability2` tinyint unsigned NOT NULL,
            `personality` tinyint unsigned NOT NULL,
            `weather_preference` tinyint unsigned NOT NULL,
            `hunger` tinyint unsigned NOT NULL,
            `care_plan` int unsigned NOT NULL,
            `held_item` int unsigned NOT NULL,
            PRIMARY KEY (`charid`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
        """)
        db.commit()
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
