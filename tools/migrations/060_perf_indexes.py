import mariadb

# table -> {index name: column}
INDEXES = {
    "char_vars": {
        "idx_char_vars_varname": "varname",
        "idx_char_vars_expiry": "expiry",
    },
    "accounts_parties": {
        "idx_accounts_parties_partyid": "partyid",
        "idx_accounts_parties_allianceid": "allianceid",
    },
    "accounts_sessions": {
        "idx_accounts_sessions_client_addr": "client_addr",
        "idx_accounts_sessions_linkshellid1": "linkshellid1",
        "idx_accounts_sessions_linkshellid2": "linkshellid2",
        "idx_accounts_sessions_unitychat": "unitychat",
    },
}


def migration_name():
    return "Add indexes to char_vars, accounts_parties and accounts_sessions hot filter columns"


def check_preconditions(cur):
    return


def _existing_indexes(cur, table):
    cur.execute("SHOW INDEX FROM {}".format(table))
    return {row[2] for row in cur.fetchall()}


def needs_to_run(cur):
    for table, indexes in INDEXES.items():
        existing = _existing_indexes(cur, table)
        if any(name not in existing for name in indexes):
            return True
    return False


def migrate(cur, db):
    try:
        for table, indexes in INDEXES.items():
            existing = _existing_indexes(cur, table)
            for name, column in indexes.items():
                if name in existing:
                    continue
                print("Creating {} on {}({})".format(name, table, column))
                cur.execute("CREATE INDEX {} ON {} ({})".format(name, table, column))
        db.commit()
    except mariadb.Error as err:
        print("Something went wrong: {}".format(err))
