import mariadb


def migration_name():
    return "Adding currency columns to char_points table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    # Ensure crystal columns exist in char_points
    cur.execute("SHOW COLUMNS FROM char_points LIKE 'aman_vouchers'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE char_points \
        ADD COLUMN `aman_vouchers` smallint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `login_points` smallint(4) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch1` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch2` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch3` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch4` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch5` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch6` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch7` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch8` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch9` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `rems_ch10` tinyint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `reclamation_marks` smallint(3) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `unity_accolades` int(5) unsigned NOT NULL DEFAULT 0, \
        ADD COLUMN `deeds` smallint(5) unsigned NOT NULL DEFAULT 0;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
