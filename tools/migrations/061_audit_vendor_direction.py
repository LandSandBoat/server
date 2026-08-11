import mariadb


def migration_name():
    return "Adding direction, npcid, npc_name, zoneid and applied_gil to audit_vendor"


def check_preconditions(cur):
    return


def column_missing(cur, column):
    cur.execute(f"show columns from audit_vendor where field = '{column}';")
    return cur.fetchone() is None


def needs_to_run(cur):
    return column_missing(cur, "npc_name")


def migrate(cur, db):
    try:
        clauses = []
        if column_missing(cur, "direction"):
            clauses.append("ADD COLUMN direction enum('sell','buy') NOT NULL DEFAULT 'sell' AFTER seller_name")
        if column_missing(cur, "npcid"):
            clauses.append("ADD COLUMN npcid int(10) unsigned NOT NULL DEFAULT 0 AFTER direction")
            clauses.append("ADD INDEX npcid (npcid)")
        clauses.append("ADD COLUMN npc_name varchar(64) DEFAULT NULL AFTER npcid")
        if column_missing(cur, "zoneid"):
            clauses.append("ADD COLUMN zoneid smallint(5) unsigned NOT NULL DEFAULT 0 AFTER npc_name")
        if column_missing(cur, "applied_gil"):
            clauses.append("ADD COLUMN applied_gil int(11) NOT NULL DEFAULT 0 AFTER totalprice")
        cur.execute("ALTER TABLE audit_vendor " + ", ".join(clauses) + ";")
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
