import mariadb

TABLES = [
    "monstrosity_species",
    "monstrosity_instincts",
    "monstrosity_instinct_mods",
    "monstrosity_exp_table",
    "monstrosity_tp_skills",
]


def migration_name():
    return "Dropping Monstrosity static tables, now held in data/monstrosity.yaml"


def check_preconditions(cur):
    return


def needs_to_run(cur):
    for table in TABLES:
        cur.execute("SHOW TABLES LIKE '{}'".format(table))
        if cur.fetchone():
            return True
    return False


def migrate(cur, db):
    try:
        for table in TABLES:
            cur.execute("DROP TABLE IF EXISTS `{}`;".format(table))
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
