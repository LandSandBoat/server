import mariadb

columns = [
    ("locked_plan", "tinyint unsigned NOT NULL DEFAULT 0 AFTER `held_item`"),
    ("appearance", "tinyint unsigned NOT NULL DEFAULT 0 AFTER `locked_plan`"),
    ("walk_progress", "int unsigned NOT NULL DEFAULT 0 AFTER `appearance`"),
]


def migration_name():
    return "Adding locked_plan, appearance and walk_progress to char_chocobos"


def check_preconditions(cur):
    return


def has_column(cur, name):
    cur.execute("SHOW COLUMNS FROM char_chocobos LIKE %s", (name,))
    return cur.fetchone() is not None


def needs_to_run(cur):
    for name, _ in columns:
        if not has_column(cur, name):
            return True
    return False


def migrate(cur, db):
    try:
        for name, definition in columns:
            if not has_column(cur, name):
                cur.execute(f"ALTER TABLE char_chocobos ADD COLUMN `{name}` {definition};")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
