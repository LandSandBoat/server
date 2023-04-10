# Internal Deps
import os
import subprocess
import sys
import re
import time
import fileinput
import shutil
import importlib
import pathlib

# Pre-flight sanity checks
def preflight_exit():
    # If double clicked on Windows: pause with an input so the user can read the error...
    if os.name == "nt" and "PROMPT" not in os.environ:
        input("Press ENTER to continue...")
    exit(-1)


# - git should installed and available
try:
    subprocess.call(["git"], stdout=subprocess.PIPE)
except Exception:
    print(
        "ERROR: Make sure git is installed and available on your system's PATH environment variable."
    )
    preflight_exit()

# If launching from somewhere that isnt <root>/tools/, figure out where dbtool.py is located, and the server root.
dbtool_dir_path = os.path.normpath(os.path.realpath(os.path.dirname(__file__)))
server_dir_path = os.path.normpath(os.path.realpath(os.path.dirname(dbtool_dir_path)))


def from_dbtool_path(path):
    return os.path.normpath(os.path.join(dbtool_dir_path, path))


def from_server_path(path):
    return os.path.normpath(os.path.join(server_dir_path, path))


# - Repo should be checked out as a git repo, not as plain files
if (
    not subprocess.call(
        ["git", "-C", server_dir_path, "status"],
        stderr=subprocess.STDOUT,
        stdout=open(os.devnull, "w"),
    )
    == 0
):
    print(
        "ERROR: The project must be checked out as a git repo (using git clone, or similar)."
    )
    preflight_exit()

# External Deps (requirements.txt)
try:
    import mariadb
    from mariadb.constants import *
    from git import Repo
    import yaml
    import colorama
except Exception as e:
    print("ERROR: Exception occured while importing external dependencies:")
    print(e)
    print(
        "Ensure you've run/re-run the command you use to install python dependencies (ex: pip install --upgrade -r requirements.txt)"
    )
    preflight_exit()

GREEN = colorama.Fore.GREEN
RED = colorama.Fore.RED
RESET = colorama.Style.RESET_ALL
NOOP = lambda *args, **kwargs: None


def print_red(str):
    print(colorama.Fore.RED + str)


def print_green(str):
    print(colorama.Fore.GREEN + str)


def populate_migrations():
    migration_list = []
    for file in sorted(
        os.scandir(from_dbtool_path("migrations")), key=lambda e: e.name
    ):
        if file.name.endswith(".py") and file.name != "utils.py":
            name = file.name.replace(".py", "")
            module = importlib.import_module("migrations." + name)
            migration_list.append(module)
    return migration_list


# Migrations are automatically scraped from the migrations folder
migrations = populate_migrations()

# These are the 'protected' files
player_data = [
    "accounts.sql",
    "accounts_banned.sql",
    "auction_house.sql",
    "char_blacklist.sql",
    "char_chocobos.sql",
    "char_effects.sql",
    "char_equip.sql",
    "char_equip_saved.sql",
    "char_exp.sql",
    "char_history.sql",
    "char_inventory.sql",
    "char_jobs.sql",
    "char_job_points.sql",
    "char_look.sql",
    "char_merit.sql",
    "char_pet.sql",
    "char_points.sql",
    "char_profile.sql",
    "char_skills.sql",
    "char_spells.sql",
    "char_stats.sql",
    "char_storage.sql",
    "char_style.sql",
    "char_unlocks.sql",
    "char_vars.sql",
    "chars.sql",
    "conquest_system.sql",
    "delivery_box.sql",
    "ip_exceptions.sql",
    "linkshells.sql",
    "server_variables.sql",
    "unity_system.sql",
]

import_files = []
import_protected = []
backups = []
database = None
host = None
port = None
login = None
password = None
db = None
cur = None
repo = Repo(server_dir_path)
db_ver = ""
current_client = None
release_version = None
release_client = None
express_enabled = False
auto_backup = 0
auto_update_client = True
mysql_bin = ""
mysql_env = shutil.which("mysql")
if mysql_env:
    mysql_bin = os.path.dirname(mysql_env).replace("\\", "/")
    if mysql_bin[-1] != "/":
        mysql_bin = mysql_bin + "/"
if os.name == "nt":
    exe = ".exe"
else:
    exe = ""
colorama.init(autoreset=True)


# Redirect errors through this to hide annoying password warning
def fetch_errors(result):
    for line in result.stderr.splitlines():
        # Safe to ignore this warning
        if "Using a password on the command line interface can be insecure" not in line:
            print_red(line)


def db_query(query):
    result = subprocess.run(
        [
            f"{mysql_bin}mysql{exe}",
            f"-h{host}",
            f"-P{str(port)}",
            f"-u{login}",
            f"-p{password}",
            database,
            f"-e {query}",
        ],
        capture_output=True,
        text=True,
    )
    fetch_errors(result)
    return result


def fetch_credentials():
    global database, host, port, login, password
    credentials = {}
    # Grab mysql credentials
    filename = from_server_path("settings/default/network.lua")
    if os.path.exists(from_server_path("settings/network.lua")):
        filename = from_server_path("settings/network.lua")
    try:
        with open(filename) as f:
            while True:
                line = f.readline()
                if not line:
                    break
                if "SQL_" in line:
                    line = line.replace(",", "").replace('"', "").replace("\n", "")
                    parts = line.split("=")
                    type = parts[0].strip()
                    val = parts[1].strip()
                    credentials[type] = val
        database = os.getenv("XI_NETWORK_SQL_DATABASE") or credentials["SQL_DATABASE"]
        host = os.getenv("XI_NETWORK_SQL_HOST") or credentials["SQL_HOST"]
        port = os.getenv("XI_NETWORK_SQL_PORT") or int(credentials["SQL_PORT"])
        login = os.getenv("XI_NETWORK_SQL_LOGIN") or credentials["SQL_LOGIN"]
        password = os.getenv("XI_NETWORK_SQL_PASSWORD") or credentials["SQL_PASSWORD"]
    except Exception as e:
        print_red("Error fetching credentials.\nCheck settings/network.lua.")
        print(e)
        return False
    return True


def fetch_versions():
    global current_client, release_version, release_client
    current_client = release_version = release_client = None
    try:
        release_version = repo.git.rev_parse(repo.head.object.hexsha, short=4)
    except Exception as e:
        print_red("Unable to read current version hash.")
        print(e)
    try:
        with open(from_server_path("settings/default/login.lua")) as f:
            while True:
                line = f.readline()
                if not line:
                    break
                match = re.match(r'\s+?CLIENT_VER =\s+"(\S+)"', line)
                if match:
                    release_client = match.group(1)
    except Exception as e:
        print_red("Unable to read settings/default/login.lua.")
        print(e)
    if os.path.exists(from_server_path("settings/login.lua")):
        try:
            with open(from_server_path("settings/login.lua")) as f:
                while True:
                    line = f.readline()
                    if not line:
                        break
                    match = re.match(r'\s+?CLIENT_VER =\s+"(\S+)"', line)
                    if match:
                        current_client = match.group(1)
        except Exception as e:
            print_red("Unable to read settings/login.lua")
            print(e)
    if db_ver and release_version:
        fetch_files(True)
    else:
        fetch_files()


def fetch_configs():
    global mysql_bin, auto_backup, auto_update_client, db_ver
    try:
        if os.path.exists(from_dbtool_path("config.yaml")):
            with open(from_dbtool_path("config.yaml")) as file:
                configs = yaml.full_load(file)
                for config in configs:
                    for key, value in config.items():
                        if key == "mysql_bin":
                            if value != "":
                                mysql_bin = value
                        if key == "auto_backup":
                            auto_backup = int(value)
                        if key == "auto_update_client":
                            auto_update_client = bool(value)
                        if key == "db_ver":
                            db_ver = value
        else:
            write_configs()
    except Exception as e:
        print(e)


def write_configs():
    with open(from_dbtool_path("config.yaml"), "w") as file:
        dump = [
            {"mysql_bin": mysql_bin},
            {"auto_backup": auto_backup},
            {"auto_update_client": auto_update_client},
            {"db_ver": db_ver},
        ]
        yaml.dump(dump, file)


def fetch_module_files():
    with open(from_server_path("modules/init.txt"), "r") as file:
        for line in file.readlines():
            if not line.startswith("#") and line.strip() and not line in ["\n", "\r\n"]:
                line = from_server_path("modules/" + line.strip())
                if pathlib.Path(line).is_dir():
                    for filename in sorted(pathlib.Path(line).glob("**/*.sql")):
                        import_files.append(str(filename).replace("\\", "/"))
                else:
                    if line.endswith(".sql"):
                        import_files.append(str(line).replace("\\", "/"))


def check_protected():
    global import_protected, express_enabled
    if not cur:
        connect()
    import_protected.clear()
    for table in player_data:
        import_protected.append("'" + table[:-4] + "'")
    cur.execute(
        f"SELECT TABLE_NAME FROM `information_schema`.`tables` WHERE `TABLE_SCHEMA` = '{database}' AND `TABLE_NAME` IN ({', '.join(import_protected)})"
    )
    tables = cur.fetchall()
    import_protected.clear()
    for value in tables:
        import_protected.append("".join(value) + ".sql")
    import_protected = [
        from_server_path("sql/" + value)
        for value in player_data
        if value not in import_protected
    ]
    if import_protected:
        express_enabled = True


def fetch_files(express=False):
    import_files.clear()
    if express:
        try:
            global express_enabled
            sql_diffs = repo.commit(db_ver).diff(
                release_version, paths=from_server_path("sql/")
            )
            if len(sql_diffs) > 0:
                for diff in sql_diffs:
                    if os.path.exists(from_server_path(diff.b_path)):
                        import_files.append(from_server_path(diff.b_path))
                if len(import_files) > 0:
                    express_enabled = True
            else:
                express_enabled = False
                if (
                    len(
                        repo.commit(db_ver).diff(
                            release_version, paths=from_server_path("tools/migrations")
                        )
                    )
                    > 0
                ):
                    express_enabled = True
        except Exception as e:
            print_red("Error checking diffs.\nCheck that hash is valid in config.yaml.")
            print(e)
    else:
        for (_, _, filenames) in os.walk(from_server_path("sql/")):
            for filename in sorted(filenames):
                import_files.append(from_server_path("sql/" + filename))
            break
    check_protected()
    backups.clear()
    for (_, _, filenames) in os.walk(from_server_path("sql/backups/")):
        for file in sorted(filenames):
            if not ".gitignore" in file:
                backups.append(from_server_path("sql/backups/" + file))
        break
    backups.sort()
    import_files.sort()
    try:
        import_files.append(
            import_files.pop(import_files.index(from_server_path("sql/triggers.sql")))
        )
    except Exception:
        pass
    fetch_module_files()


def write_version(silent=False):
    global db_ver
    update_client = auto_update_client
    if not silent and current_client != release_client:
        update_client = input("Update client version? [y/N] ").lower() == "y"
    update_client = update_client and release_client
    db_ver = release_version
    write_configs()
    if os.path.exists(from_server_path("settings/login.lua")):
        try:
            if current_client != release_client:
                for line in fileinput.input(
                    from_server_path("settings/login.lua"), inplace=True
                ):
                    match = re.match(r"\s+?CLIENT_VER =\s+(\S+)", line)
                    if match:
                        line = '    CLIENT_VER = "' + release_client + '",\n'
                    print(line, end="")
            else:
                update_client = False
            if update_client:
                print_green("Updated client version!")
            fetch_versions()
        except Exception as e:
            fileinput.close()
            print_red("Error writing version.")
            print(e)


def import_file(file):
    file = os.path.normpath(file).replace("\\", "/")
    if not os.path.exists(file):
        print_red(
            f"Trying to import file that does not exist ({file}), or is an incomplete path."
        )
        return
    print("Importing " + file)
    query = f"SET autocommit=0; SET unique_checks=0; SET foreign_key_checks=0; SOURCE {file}; SET unique_checks=1; SET foreign_key_checks=1; COMMIT;"
    _ = db_query(query)


def connect():
    global db, cur
    try:
        db = mariadb.connect(
            host=host, user=login, passwd=password, db=database, port=port
        )
        cur = db.cursor()
    except mariadb.Error as err:
        if err.errno == mariadb.constants.ERR.ER_ACCESS_DENIED_ERROR:
            print_red(
                "Incorrect mysql_login or mysql_password, update settings/network.lua."
            )
            close()
        elif err.errno == mariadb.constants.ERR.ER_BAD_DB_ERROR:
            print_red("Database " + database + " does not exist.")
            if (
                input(
                    "Would you like to create new database: " + database + "? [y/N] "
                ).lower()
                == "y"
            ):
                result = subprocess.run(
                    [
                        f"{mysql_bin}mysqladmin{exe}",
                        f"-h{host}",
                        f"-P{str(port)}",
                        f"-u{login}",
                        f"-p{password}",
                        "CREATE",
                        database,
                    ],
                    capture_output=True,
                    text=True,
                )
                fetch_errors(result)
                setup_db()
                connect()
            else:
                quit()
        else:
            print_red(err)
        return False
    return True


def close():
    if db:
        print("Closing connection...")
        cur.close()
        db.close()
    time.sleep(0.5)
    quit()


def setup_db():
    fetch_files()
    for sql_file in import_files:
        import_file(sql_file)
    print_green("Finished importing!")
    write_version()


def backup_db(silent=False, lite=False):
    if silent or input("Would you like to backup your database? [y/N] ").lower() == "y":
        if not silent:
            lite = (
                input("Would you like to only backup protected tables? [y/N] ").lower()
                == "y"
            )
        dumpcmd = [
            f"{mysql_bin}mysqldump{exe}",
            "--hex-blob",
            "--add-drop-trigger",
            f"-h{host}",
            f"-P{str(port)}",
            f"-u{login}",
            f"-p{password}",
            database,
        ]
        if lite:
            tables = []
            for table in player_data:
                tables.append(table[:-4])
            dumpcmd.extend(tables)
            outfile_path = f"{server_dir_path}/sql/backups/{database}-{time.strftime('%Y%m%d-%H%M%S')}-lite.sql"
        else:
            if db_ver:
                outfile_path = f"{server_dir_path}/sql/backups/{database}-{time.strftime('%Y%m%d-%H%M%S')}-{db_ver}.sql"
            else:
                outfile_path = f"{server_dir_path}/sql/backups/{database}-{time.strftime('%Y%m%d-%H%M%S')}-full.sql"
        with open(outfile_path, "w") as outfile:
            result = subprocess.run(
                dumpcmd,
                stdout=outfile,
                stderr=subprocess.PIPE,
                text=True,
            )
            fetch_errors(result)
            print_green("Database saved!")
            time.sleep(0.5)


def express_update(silent=False):
    update_db(silent, True)


def update_db(silent=False, express=False):
    global express_enabled
    if not silent or auto_backup:
        backup_db(silent, auto_backup == 2)
    if not express:
        fetch_files()
    if not silent:
        if import_protected:
            print_green(
                "The following PROTECTED tables could not be found and will be imported:"
            )
            for sql_file in import_protected:
                print(sql_file)
        if import_files:
            print_green("The following files will be imported:")
            for sql_file in import_files:
                if pathlib.Path(sql_file).name not in player_data:
                    print(os.path.normpath(sql_file).replace("\\", "/"))
    if silent or input("Proceed with update? [y/N] ").lower() == "y":
        for sql_file in import_protected:
            import_file(sql_file)
        for sql_file in import_files:
            if pathlib.Path(sql_file).name not in player_data:
                import_file(sql_file)
        print_green("Finished importing!")
        express_enabled = False
        run_all_migrations(silent or express)
        write_version(silent)


def adjust_mysql_bin():
    global mysql_bin
    while True:
        choice = input(
            "Please enter the path to your MySQL bin directory or press enter to check PATH.\ne.g. C:\\Program Files\\MariaDB 10.6\\bin\\\n> "
        ).replace("\\", "/")
        if choice == "":
            mysql_file = shutil.which("mysql")
            if not mysql_file:
                continue
            choice = os.path.dirname(mysql_file).replace("\\", "/")
        if choice and choice[-1] != "/":
            choice = choice + "/"
        if os.path.exists(choice + "mysql" + exe):
            mysql_bin = choice
            break


def adjust_auto_backup():
    global auto_backup
    while True:
        choice = input(
            "Would you like a backup to automatically be created when running an update from the command line? [y/n] "
        )
        if choice == "y":
            choice = input(
                "Would you like to only automatically backup protected tables? [y/N] "
            )
            if choice == "y":
                auto_backup = 2
                break
            else:
                auto_backup = 1
                break
        elif choice == "n":
            auto_backup = 0
            break
        bad_selection()


def adjust_auto_update_client():
    global auto_update_client
    while True:
        choice = input(
            "Would you like to automatically update the client version when running an update from the command line? [y/n] "
        )
        if choice == "y":
            auto_update_client = True
            break
        elif choice == "n":
            auto_update_client = False
            break
        bad_selection()


def run_all_migrations(silent=False):
    migrations_needed = []
    print_green("Checking migrations...")
    for migration in migrations:
        check_migration(migration, migrations_needed, silent)
    if len(migrations_needed) > 0:
        if not silent:
            if (
                input("Migrations required!\nRun missing migrations? [y/N] ").lower()
                != "y"
            ):
                return
            else:
                backup_db()
        if os.path.exists(from_dbtool_path("migration_errors.log")):
            os.remove(from_dbtool_path("migration_errors.log"))
        for migration in migrations_needed:
            print("Running migrations for " + migration.migration_name() + "...")
            migration.migrate(cur, db)
        print_green("Finished migrations!")
        if os.path.exists(from_dbtool_path("migration_errors.log")):
            print_red(
                "There were errors with some migrations, this likely means one or more characters \n"
                "have corrupt data in some field. See migration_errors.log for more details."
            )
        time.sleep(0.5)
    else:
        print_green("No migrations required.")
        time.sleep(0.5)


def check_migration(migration, migrations_needed, silent=False):
    migration.check_preconditions(cur)
    if not migration.needs_to_run(cur):
        if not silent:
            print_red(
                "["
                + colorama.Fore.GREEN
                + "*"
                + colorama.Fore.RED
                + "] "
                + colorama.Style.RESET_ALL
                + migration.migration_name()
            )
        return
    migrations_needed.append(migration)
    if not silent:
        print_red("[ ] " + colorama.Style.RESET_ALL + migration.migration_name())


def restore_backup():
    backup_db()
    fetch_files()
    while len(backups):
        for i, backup in enumerate(backups):
            print_green(
                str(i + 1) + colorama.Style.RESET_ALL + ". " + backup.replace("\\", "/")
            )
        choice = input(
            'Choose a number to import, or type "delete #" to delete a file.\n> '
        )
        if choice.isnumeric():
            choice = int(choice)
            if 0 < choice < len(backups) + 1:
                backup_file = backups[choice - 1].replace("\\", "/")
                print(colorama.ansi.clear_screen())
                print_red(
                    "If this is a full backup created by this tool, it is recommended to manually change \n"
                    "the DB_VER in config.yaml to the hash sequence in the filename, after \n"
                    "the database name and the timestamp, so that express update functions properly."
                )
                if input("Import " + backup_file + "? [y/N] ").lower() == "y":
                    import_file(backup_file)
                    print_green("Finished importing!")
                    break
            else:
                bad_selection()
        else:
            choice = re.match(r"^delete (\d+)$", choice)
            if choice:
                choice = int(choice.group(1))
                if 0 < choice < len(backups) + 1:
                    backup_file = backups[choice - 1]
                    print(colorama.ansi.clear_screen())
                    if input("Delete " + backup_file + "? [y/N] ").lower() == "y":
                        os.remove(backup_file)
                        print_green("Deleted " + backup_file + "!")
                        fetch_files()
                else:
                    bad_selection()
            else:
                return


def reset_db():
    backup_db()
    print_red("Are you sure you want to reset your database to default?")
    choice = input('Type "reset ' + database + '" to confirm.\n> ')
    choice = re.match(r"^reset (\w+)$", choice)
    if choice and choice.group(1) == database:
        setup_db()


def bad_selection():
    print_red("Invalid selection.")
    time.sleep(0.5)


def settings():
    fetch_configs()
    print_green("Current MySQL bin location: " + colorama.Style.RESET_ALL + mysql_bin)
    if input("Change this location? [y/N] ").lower() == "y":
        adjust_mysql_bin()
    print_green(
        "Automatic backup for command line updates: "
        + colorama.Style.RESET_ALL
        + str(bool(auto_backup))
    )
    if input("Change this? [y/N] ").lower() == "y":
        adjust_auto_backup()
    print_green(
        "Automatic client version update for command line updates: "
        + colorama.Style.RESET_ALL
        + str(auto_update_client)
    )
    if input("Change this? [y/N] ").lower() == "y":
        adjust_auto_update_client()
    write_configs()


def set_external_ip(ip_str):
    global mysql_bin, exe
    query = f"""
    UPDATE zone_settings SET zoneip = '{ip_str}';
    """
    print("Executing query:")
    print(query)
    _ = db_query(query)


def set_external_ip_dialog():
    import urllib.request

    if input("Make server public-facing? [y/N] ").lower() == "y":
        external_ip = urllib.request.urlopen("https://ident.me").read().decode("utf8")
        print_green(f"Detected your public-facing IP as: {external_ip}")
        if input("Is this correct? [y/N] ").lower() == "y":
            set_external_ip(external_ip)
        else:
            external_ip = input("Please enter your public-facing IP: ")
            if len(external_ip.strip()) > 0:
                set_external_ip(external_ip)


def print_db_tables_by_size():
    global mysql_bin, exe

    query = """
    SELECT table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
    FROM information_schema.TABLES
    WHERE ROUND(((data_length + index_length) / 1024 / 1024), 2) > 1.0
    ORDER BY (data_length + index_length) DESC;
    """

    print("Executing query:")
    print(query)
    result = db_query(query)
    print(result.stdout)


def offload_to_auction_house_history():
    global mysql_bin, exe

    if (
        input(
            "This feature is very slow, and runs the risk of wiping out some or all of your auction_house history.\n"
            + RED
            + "USE AT YOUR OWN RISK!\n"
            + RESET
            + "Do you wish to continue? [y/N] "
        ).lower()
        != "y"
    ):
        return

    if not cur:
        connect()

    ah_before = db_query("SELECT COUNT(*) FROM auction_house;").stdout
    ah_history_before = db_query("SELECT COUNT(*) FROM auction_house_history;").stdout

    cur.execute("SELECT DISTINCT itemid FROM auction_house;")

    items = cur.fetchall()
    index = 0
    for itemid in items:
        if index % 500 == 0:
            percent = (index / len(items)) * 100
            print(
                f"Offloading historical data auction_house data: {percent:.1f}% ({index}/{len(items)})"
            )
        index = index + 1

        query = f"""
        START TRANSACTION;
        SET @itemid = {itemid[0]};

        -- Insert into history table
        INSERT INTO auction_house_history
        SELECT * FROM auction_house
        WHERE
            itemid = @itemid AND
            buyer_name IS NOT NULL AND -- Sold
            id NOT IN (
                SELECT id
                FROM (
                    -- Most recent 20 unsold listings for item @itemid
                    SELECT id, itemid, buyer_name
                    FROM auction_house
                    WHERE
                        itemid = @itemid AND
                        buyer_name IS NOT NULL
                    ORDER BY sell_date DESC
                    LIMIT 20
                ) listed
            );

        -- Delete from non-history (same query as above, just for deleting)
        DELETE auction_house.*
        FROM auction_house
        WHERE
            itemid = @itemid AND
            buyer_name IS NOT NULL AND -- Sold
            id NOT IN (
                SELECT id
                FROM (
                    -- Most recent 20 unsold listings for item @itemid
                    SELECT id, itemid, buyer_name
                    FROM auction_house
                    WHERE
                        itemid = @itemid AND
                        buyer_name IS NOT NULL
                    ORDER BY sell_date DESC
                    LIMIT 20
                ) listed
            );
        COMMIT;
        """
        db_query(query)

    print("Done!")

    print("Number of rows in auction_house (before):")
    print(ah_before)

    print("Number of rows in auction_house_history (before):")
    print(ah_history_before)

    print("Number of rows in auction_house (after):")
    print(db_query("SELECT COUNT(*) FROM auction_house;").stdout)

    print("Number of rows in auction_house_history (after):")
    print(db_query("SELECT COUNT(*) FROM auction_house_history;").stdout)


def announce_menu():
    from announce import send_server_message

    message = input("What message would you like to send to the whole server?\n> ")
    if (
        input(
            "Are you sure you want to send the this to the whole server? [y/N]"
        ).lower()
        == "y"
    ):
        send_server_message(message)


# fmt: off
def present_menu(title, contents):
    # Determine width of entire menu, including multiline titles
    # and menu items
    length = 0
    title_parts = title.split("\n")

    for part in title_parts:
        length = max(len(part), length)

    for value in contents.values():
        length = max(len(value[0]), length)

    # Add some more padding to account for the manual styling of
    # menu options and spacings
    option_pad = 3
    length = length + option_pad

    LEFT  = "| "
    RIGHT = " |"

    # Present title
    print(
        GREEN + "o" + RED + "-" + "-" * length + "-" + GREEN + "o"
    )
    for part in title_parts:
        print(
            RED + LEFT + RESET + part.center(length) + RED + RIGHT
        )
    print(
        GREEN + "o" + RED + "-" + "-" * length + "-" + GREEN + "o"
    )

    # Menu options
    for key, value in contents.items():
        description = value[0]
        print(
            RED + LEFT + GREEN + key + RESET + ". " + description + " " * (length - len(description) - option_pad) + RED + RIGHT
        )

    # Footer
    print(colorama.Fore.GREEN + "o" + colorama.Fore.RED + "-" + "-" * length + "-" + colorama.Fore.GREEN + "o\n")

    # Handle inputs
    selection = input("> ").lower()
    print(colorama.ansi.clear_screen())
    contents.get(selection, ["", bad_selection])[1]()
# fmt: on


def configure_and_launch_multi_process_by_zonetype():
    db_query(
        f"""
        UPDATE xidb.zone_settings SET zoneport = 54230 WHERE zonetype = 0;
        UPDATE xidb.zone_settings SET zoneport = 54231 WHERE zonetype = 1;
        UPDATE xidb.zone_settings SET zoneport = 54232 WHERE zonetype = 2;
        UPDATE xidb.zone_settings SET zoneport = 54233 WHERE zonetype = 3;
        UPDATE xidb.zone_settings SET zoneport = 54234 WHERE zonetype = 4;
        UPDATE xidb.zone_settings SET zoneport = 54235 WHERE zonetype = 5;
        UPDATE xidb.zone_settings SET zoneport = 54236 WHERE zonetype = 6;
        """
    )

    result = db_query(
        f"""
        SELECT DISTINCT zoneport from zone_settings ORDER BY zoneport ASC;
        """
    )

    ports = result.stdout.split("\n")[1:-1]

    executable = from_server_path(f"xi_map{exe}")

    # fmt: off
    for port in ports:
        print(f"Launching {executable} --log log/map-server-{port}.log --ip 127.0.0.1 --port {port}")
        subprocess.Popen(
            [executable, "--log", f"log/map-server-{port}.log", "--ip", "127.0.0.1", "--port", port],
            shell=True,
            creationflags=subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP,
            cwd=server_dir_path,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    # fmt: on


def update_submodules():
    # fmt: off
    result = subprocess.run(
        ["git", "submodule", "update", "--init", "--recursive", "--progress"], capture_output=True, text=True).stdout
    print(result)
    # fmt: on


def tasks_menu():
    present_menu(
        "Maintenance Tasks",
        {
            "1": ["Update git submodules", update_submodules],
            "2": ["Set zone IP addresses", set_external_ip_dialog],
            "3": ["Server-wide announcement", announce_menu],
            "4": ["Show table sizes (min 2MB)", print_db_tables_by_size],
            # "5": [
            #     "Offload historical auction data to auction_house_history",
            #     offload_to_auction_house_history,
            # ],
            "c": [
                "Configure and launch multi-process server (by zonetype, 7 processes)",
                configure_and_launch_multi_process_by_zonetype,
            ],
            "q": ["Quit to main menu", NOOP],
        },
    )


def main():
    try:
        global mysql_bin, exe
        if fetch_credentials() == False:
            return
        fetch_configs()
        # Check MySQL path/availability
        if not os.path.exists(mysql_bin + "mysql" + exe):
            adjust_mysql_bin()
            write_configs()
        fetch_versions()
        # CLI args
        if len(sys.argv) > 1:
            arg1 = str(sys.argv[1])
            if "backup" == arg1:
                if len(sys.argv) > 2 and str(sys.argv[2]) == "lite":
                    backup_db(True, True)
                else:
                    backup_db(True)
                return
            elif "migrate" == arg1:
                if connect() != False:
                    run_all_migrations(True)
                    close()
                return
            elif "update" == arg1:
                full_update = False
                if len(sys.argv) > 2 and str(sys.argv[2]) == "full":
                    full_update = True
                if (
                    db_ver
                    and release_version
                    and not express_enabled
                    and not full_update
                ):
                    print_green("Database is up to date.")
                    return
                if connect() != False:
                    if express_enabled and not full_update:
                        express_update(True)
                    else:
                        update_db(True)
                    close()
                return
            elif "setup" == arg1:
                if len(sys.argv) > 2 and str(sys.argv[2]) == database:
                    result = subprocess.run(
                        [
                            f"{mysql_bin}mysqladmin{exe}",
                            f"-h{host}",
                            f"-P{str(port)}",
                            f"-u{login}",
                            f"-p{password}",
                            "CREATE",
                            database,
                        ],
                        capture_output=True,
                        text=True,
                    )
                    fetch_errors(result)
                    setup_db()
                return
        # Main loop
        print(colorama.ansi.clear_screen())
        connect()
        while cur:
            colorama.init(autoreset=True)
            title = (
                "LandSandBoat Database Management Tool\n" + "Connected to " + database
            )
            if db_ver:
                title = title + "\n" + str("#" + db_ver)

            options = {
                "1": ["Update DB", update_db],
                "2": ["Check migrations", run_all_migrations],
                "3": ["Backup", backup_db],
                "4": ["Restore/Import", restore_backup],
                "r": ["Reset DB", reset_db],
                "t": ["Maintenance Tasks", tasks_menu],
                "s": ["Settings", settings],
                "q": ["Quit", close],
            }

            if express_enabled:
                append = {
                    "e": [
                        "Express Update " + "(#" + release_version + ")",
                        express_update,
                    ],
                }
                options = {**append, **options}

            present_menu(title, options)
    except KeyboardInterrupt:
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)


if __name__ == "__main__":
    main()
