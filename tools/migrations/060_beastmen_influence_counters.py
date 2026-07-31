import mariadb


def migration_name():
    return "Replacing conquest beastmen_influence with mob_kills and player_homepoints"

def check_preconditions(cur):
    return

def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM conquest_system LIKE 'mob_kills'")

    if cur.fetchone():
        return False

    return True

def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE `conquest_system` \
            DROP COLUMN `beastmen_influence`, \
            ADD COLUMN `mob_kills` int(10) NOT NULL DEFAULT 0 AFTER `windurst_influence`, \
            ADD COLUMN `player_homepoints` int(10) NOT NULL DEFAULT 0 AFTER `mob_kills`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
