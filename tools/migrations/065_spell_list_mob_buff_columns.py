import mariadb


def migration_name():
    return "Adding status_effect and status_effect_tier columns to spell_list table"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    cur.execute("SHOW COLUMNS FROM spell_list LIKE 'status_effect_tier'")
    if not cur.fetchone():
        return True
    return False


def migrate(cur, db):
    try:
        cur.execute(
            "ALTER TABLE spell_list \
        ADD COLUMN IF NOT EXISTS `status_effect` smallint(5) unsigned DEFAULT NULL AFTER `content_tag`, \
        ADD COLUMN IF NOT EXISTS `status_effect_tier` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `status_effect`;"
        )
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
