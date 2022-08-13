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
    if os.name == 'nt' and 'PROMPT' not in os.environ:
        input('Press ENTER to continue...')
    exit(-1)

# - git should installed and available
try:
    subprocess.call(["git"], stdout=subprocess.PIPE)
except: # lgtm [py/catch-base-exception]
    print("ERROR: Make sure git is installed and available on your system's PATH environment variable.")
    preflight_exit()

# - dbtool.py is designed to be run from <root>/tools folder, not <root>
if not os.path.isfile("./dbtool.py"):
    print("ERROR: dbtool.py is designed to be run from the <root>/tools folder, not <root>. Please run from the tools folder.")
    preflight_exit()

# - Repo should be checked out as a git repo, not as plain files
if not subprocess.call(['git', '-C', "../", 'status'], stderr=subprocess.STDOUT, stdout = open(os.devnull, 'w')) == 0:
    print("ERROR: The project must be checked out as a git repo (using git clone, or similar).")
    preflight_exit()

# External Deps (requirements.txt)
try:
    import mysql.connector
    from git import Repo
    import yaml
    import colorama
except Exception as e:
    print("ERROR: Exception occured while importing external dependencies:")
    print(e)
    preflight_exit()

def populate_migrations():
    migration_list = []
    for file in os.scandir("migrations"):
        if file.name.endswith(".py") and file.name != "utils.py":
            name = file.name.replace(".py", "")
            module = importlib.import_module("migrations." + name)
            migration_list.append(module)
    return migration_list

# Migrations are automatically scraped from the migrations folder
migrations = populate_migrations()

# These are the 'protected' files
player_data = [
    'accounts.sql',
    'accounts_banned.sql',
    'auction_house.sql',
    'char_blacklist.sql',
    'char_effects.sql',
    'char_equip.sql',
    'char_exp.sql',
    'char_history.sql',
    'char_inventory.sql',
    'char_jobs.sql',
    'char_job_points.sql',
    'char_look.sql',
    'char_merit.sql',
    'char_pet.sql',
    'char_points.sql',
    'char_profile.sql',
    'char_skills.sql',
    'char_spells.sql',
    'char_stats.sql',
    'char_storage.sql',
    'char_style.sql',
    'char_unlocks.sql',
    'char_vars.sql',
    'chars.sql',
    'conquest_system.sql',
    'delivery_box.sql',
    'ip_exceptions.sql',
    'linkshells.sql',
    'server_variables.sql',
    'unity_system.sql',
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
repo = Repo('../')
db_ver = ''
current_client = None
release_version = None
release_client = None
express_enabled = False
auto_backup = 0
auto_update_client = True
mysql_bin = ''
mysql_env = shutil.which('mysql')
if mysql_env:
    mysql_bin = os.path.dirname(mysql_env).replace('\\','/')
    if mysql_bin[-1] != '/':
        mysql_bin = mysql_bin + '/'
if os.name == 'nt':
    exe = '.exe'
else:
    exe = ''
log_errors = ' 2>>error.log'
colorama.init(autoreset=True)

# Redirect errors through this to hide annoying password warning
def fetch_errors():
    try:
        with open('error.log') as f:
            while True:
                line = f.readline()
                if not line: break
                if 'Using a password on the command line interface can be insecure.' in line:
                    continue
                print(colorama.Fore.RED + line)
        os.remove('error.log')
    except: # lgtm [py/catch-base-exception]
        return

def fetch_credentials():
    global database, host, port, login, password
    credentials = {}

    # Grab mysql credentials
    filename = '../settings/default/network.lua'
    if os.path.exists('../settings/network.lua'):
        filename = '../settings/network.lua'
    try:
        with open(filename) as f:
            while True:
                line = f.readline()
                if not line: break
                if "SQL_" in line:
                    line = line.replace(',', '').replace('\"', '').replace('\n', '')
                    parts = line.split("=")
                    type = parts[0].strip()
                    val = parts[1].strip()
                    credentials[type] = val

        database = os.getenv('XI_NETWORK_SQL_DATABASE') or credentials['SQL_DATABASE']
        host = os.getenv('XI_NETWORK_SQL_HOST') or credentials['SQL_HOST']
        port = os.getenv('XI_NETWORK_SQL_PORT') or int(credentials['SQL_PORT'])
        login = os.getenv('XI_NETWORK_SQL_LOGIN') or credentials['SQL_LOGIN']
        password = os.getenv('XI_NETWORK_SQL_PASSWORD') or credentials['SQL_PASSWORD']
    except: # lgtm [py/catch-base-exception]
        print(colorama.Fore.RED + 'Error fetching credentials.\nCheck ../settings/network.lua.')
        return False

def fetch_versions():
    global current_client, release_version, release_client
    current_client = release_version = release_client = None

    try:
        release_version = repo.git.rev_parse(repo.head.object.hexsha, short=4)
    except: # lgtm [py/catch-base-exception]
        print(colorama.Fore.RED + 'Unable to read current version hash.')

    try:
        with open('../settings/default/login.lua') as f:
            while True:
                line = f.readline()
                if not line: break
                match = re.match(r'\s+?CLIENT_VER =\s+"(\S+)"', line)
                if match:
                    release_client = match.group(1)
    except: # lgtm [py/catch-base-exception]
        print(colorama.Fore.RED + 'Unable to read ../settings/default/login.lua.')
    if os.path.exists('../settings/login.lua'):
        try:
            with open('../settings/login.lua') as f:
                while True:
                    line = f.readline()
                    if not line: break
                    match = re.match(r'\s+?CLIENT_VER =\s+"(\S+)"', line)
                    if match:
                        current_client = match.group(1)
        except: # lgtm [py/catch-base-exception]
            print(colorama.Fore.RED + 'Unable to read ../settings/login.lua')

    if db_ver and release_version:
        fetch_files(True)
    else:
        fetch_files()

def fetch_configs():
    global mysql_bin, auto_backup, auto_update_client, db_ver
    try:
        with open(r'config.yaml') as file:
            configs = yaml.full_load(file)
            for config in configs:
                for key, value in config.items():
                    if key == 'mysql_bin':
                        if value != '':
                            mysql_bin = value
                    if key == 'auto_backup':
                        auto_backup = int(value)
                    if key == 'auto_update_client':
                        auto_update_client = bool(value)
                    if key == 'db_ver':
                        db_ver = value
    except: # lgtm [py/catch-base-exception]
        write_configs()

def write_configs():
    with open(r'config.yaml', 'w') as file:
        dump = [{'mysql_bin' : mysql_bin}, {'auto_backup' : auto_backup}, {'auto_update_client' : auto_update_client}, {'db_ver' : db_ver}]
        yaml.dump(dump, file)

def fetch_module_files():
    with open('../modules/init.txt', 'r') as file:
        for line in file.readlines():
            if not line.startswith('#') and line.strip() and not line in ['\n', '\r\n']:
                line = "../modules/" + line.strip()
                if pathlib.Path(line).is_dir():
                    for filename in pathlib.Path(line).glob('**/*.sql'):
                        import_files.append(str(filename).replace('\\', '/'))
                else:
                    if line.endswith(".sql"):
                        import_files.append(str(line).replace('\\', '/'))

def check_protected():
    global import_protected, express_enabled
    if not cur:
        connect()
    import_protected.clear()
    for table in player_data:
        import_protected.append("'" + table[:-4] + "'")
    cur.execute("SELECT TABLE_NAME FROM `information_schema`.`tables` WHERE `TABLE_SCHEMA` = '{}' AND `TABLE_NAME` IN ({})".format(database,', '.join(import_protected)))
    tables = cur.fetchall()
    import_protected.clear()
    for value in tables:
        import_protected.append(''.join(value) + '.sql')
    import_protected = [value for value in player_data if value not in import_protected]
    if import_protected:
        express_enabled = True

def fetch_files(express=False):
    import_files.clear()
    if express:
        try:
            global express_enabled
            sql_diffs = repo.commit(db_ver).diff(release_version,paths='sql/')
            if len(sql_diffs) > 0:
                for diff in sql_diffs:
                    import_files.append(diff.a_path[4:])
                express_enabled = True
            else:
                express_enabled = False
                if len(repo.commit(db_ver).diff(release_version,paths='tools/migrations')) > 0:
                    express_enabled = True
        except: # lgtm [py/catch-base-exception]
            print(colorama.Fore.RED + 'Error checking diffs.\nCheck that hash is valid in config.yaml.')
    else:
        for (_, _, filenames) in os.walk('../sql/'):
            import_files.extend(filenames)
            break
    check_protected()
    backups.clear()
    for (_, _, filenames) in os.walk('../sql/backups/'):
        backups.extend(filenames)
        if '.gitignore' in backups:
            backups.remove('.gitignore')
        break
    backups.sort()
    import_files.sort()
    try:
        import_files.append(import_files.pop(import_files.index('triggers.sql')))
    except: # lgtm [py/catch-base-exception]
        pass
    fetch_module_files()

def write_version(silent=False):
    global db_ver
    update_client = auto_update_client
    if not silent and current_client != release_client:
        update_client = input('Update client version? [y/N] ').lower() == 'y'
    update_client = update_client and release_client
    db_ver = release_version
    write_configs()

    if os.path.exists('../settings/login.lua'):
        try:
            if current_client != release_client:
                for line in fileinput.input('../settings/login.lua', inplace=True):
                    match = re.match(r'\s+?CLIENT_VER =\s+(\S+)', line)
                    if match:
                        line = '    CLIENT_VER = "' + release_client + '",\n'
                    print(line, end='')
            else:
                update_client = False
            if update_client:
                print(colorama.Fore.GREEN + 'Updated client version!')
            fetch_versions()
        except: # lgtm [py/catch-base-exception]
            fileinput.close()
            print(colorama.Fore.RED + 'Error writing version.')

def import_file(file):
    print('Importing ' + file + '...')
    query = 'SET autocommit=0; SET unique_checks=0; SET foreign_key_checks=0; source ../sql/{}; SET unique_checks=1; SET foreign_key_checks=1; COMMIT;'.format(file)

    if 'modules' in file:
        query = 'SET autocommit=0; SET unique_checks=0; SET foreign_key_checks=0; source {}; SET unique_checks=1; SET foreign_key_checks=1; COMMIT;'.format(file)

    result = subprocess.run([
        '{}mysql{}'.format(mysql_bin, exe),
        '-h', host,
        '-P', str(port),
        '-u', login,
        '-p{}'.format(password),
        database,
        '-e', query],
        capture_output=True, text=True)

    for line in result.stderr.splitlines():
        # Safe to ignore this warning
        if 'Using a password on the command line interface can be insecure' not in line:
            print(colorama.Fore.RED + line)

def connect():
    global db, cur
    try:
        db = mysql.connector.connect(host=host,
                user=login,
                passwd=password,
                db=database,
                port=port,
                use_pure=True)
        cur = db.cursor()
    except mysql.connector.Error as err:
        if err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
            print(colorama.Fore.RED + 'Incorrect mysql_login or mysql_password, update ../settings/network.lua.')
            close()
            return False
        elif err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
            print(colorama.Fore.RED + 'Database ' + database + ' does not exist.')
            if input('Would you like to create new database: ' + database + '? [y/N] ').lower() == 'y':
                create_command = '"' + mysql_bin + 'mysqladmin' + exe + '" -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' CREATE ' + database
                os.system(create_command + log_errors)
                fetch_errors()
                setup_db()
                connect()
            else:
                quit()
        else:
            print(colorama.Fore.RED + err)
        return False

def close():
    if db:
        print('Closing connection...')
        cur.close()
        db.close()
    time.sleep(0.5)

def setup_db():
    fetch_files()
    for sql_file in import_files:
        import_file(sql_file)
    print(colorama.Fore.GREEN + 'Finished importing!')
    write_version()

def backup_db(silent=False,lite=False):
    if silent or input('Would you like to backup your database? [y/N] ').lower() == 'y':
        if not silent:
            lite = input('Would you like to only backup protected tables? [y/N] ').lower() == 'y'
        if lite:
            tables = ' '
            for table in player_data:
                tables += table[:-4] + ' '
            dumpcmd = '"' + mysql_bin + 'mysqldump' + exe + '" --hex-blob --add-drop-trigger -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' ' + database +\
                tables + '> ../sql/backups/' + database + '-' + time.strftime('%Y%m%d-%H%M%S') + '-lite.sql'
        else:
            if db_ver:
                dumpcmd = '"' + mysql_bin + 'mysqldump' + exe + '" --hex-blob --add-drop-trigger -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' ' + database +\
                    ' > ../sql/backups/' + database + '-' + time.strftime('%Y%m%d-%H%M%S') + '-' + db_ver + '.sql'
            else:
                dumpcmd = '"' + mysql_bin + 'mysqldump' + exe + '" --hex-blob --add-drop-trigger -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' ' + database +\
                    ' > ../sql/backups/' + database + time.strftime('%Y%m%d-%H%M%S') + '-full.sql'
        os.system(dumpcmd + log_errors)
        fetch_errors()
        print(colorama.Fore.GREEN + 'Database saved!')
        time.sleep(0.5)

def express_update(silent=False):
    update_db(silent, True)

def update_db(silent=False,express=False):
    global express_enabled
    if not silent or auto_backup:
        backup_db(silent, auto_backup == 2)
    if not express:
        fetch_files()
    if not silent:
        if import_protected:
            print(colorama.Fore.GREEN + 'The following PROTECTED tables could not be found and will be imported:')
            for sql_file in import_protected:
                print(sql_file)
        if import_files:
            print(colorama.Fore.GREEN + 'The following files will be imported:')
            for sql_file in import_files:
                if sql_file not in player_data:
                    print(sql_file)
    if silent or input('Proceed with update? [y/N] ').lower() == 'y':
        for sql_file in import_protected:
            import_file(sql_file)
        for sql_file in import_files:
            if sql_file not in player_data:
                import_file(sql_file)
        print(colorama.Fore.GREEN + 'Finished importing!')
        express_enabled = False
        run_all_migrations(silent or express)
        write_version(silent)

def adjust_mysql_bin():
    global mysql_bin
    while True:
        choice = input('Please enter the path to your MySQL bin directory or press enter to check PATH.\ne.g. C:\\Program Files\\MariaDB 10.5\\bin\\\n> ').replace('\\', '/')
        if choice == '':
            mysql_file = shutil.which('mysql')
            if not mysql_file:
                continue
            choice = os.path.dirname(mysql_file).replace('\\','/')
        if choice and choice[-1] != '/':
            choice = choice + '/'
        if os.path.exists(choice + 'mysql' + exe):
            mysql_bin = choice
            break

def adjust_auto_backup():
    global auto_backup
    while True:
        choice = input('Would you like a backup to automatically be created when running an update from the command line? [y/n] ')
        if choice == 'y':
            choice = input('Would you like to only automatically backup protected tables? [y/N] ')
            if choice == 'y':
                auto_backup = 2
                break
            else:
                auto_backup = 1
                break
        elif choice == 'n':
            auto_backup = 0
            break
        bad_selection()

def adjust_auto_update_client():
    global auto_update_client
    while True:
        choice = input('Would you like to automatically update the client version when running an update from the command line? [y/n] ')
        if choice == 'y':
            auto_update_client = True
            break
        elif choice == 'n':
            auto_update_client = False
            break
        bad_selection()

def run_all_migrations(silent=False):
    migrations_needed = []
    print(colorama.Fore.GREEN + 'Checking migrations...')
    for migration in migrations:
        check_migration(migration, migrations_needed, silent)
    if len(migrations_needed) > 0:
        if not silent:
            if input('Migrations required!\nRun missing migrations? [y/N] ').lower() != 'y':
                return
            else:
                backup_db()
        if os.path.exists('migration_errors.log'):
            os.remove('migration_errors.log')
        for migration in migrations_needed:
            print('Running migrations for ' + migration.migration_name() + '...')
            migration.migrate(cur, db)
        print(colorama.Fore.GREEN + 'Finished migrations!')
        if os.path.exists('migration_errors.log'):
            print(colorama.Fore.RED + 'There were errors with some migrations, this likely means one or more characters \n'
                'have corrupt data in some field. See migration_errors.log for more details.')
        time.sleep(0.5)
    else:
        print(colorama.Fore.GREEN + 'No migrations required.')
        time.sleep(0.5)

def check_migration(migration, migrations_needed, silent=False):
    migration.check_preconditions(cur)
    if not migration.needs_to_run(cur):
        if not silent:
            print(colorama.Fore.RED + '[' + colorama.Fore.GREEN + '*' + colorama.Fore.RED + '] ' + colorama.Style.RESET_ALL + migration.migration_name())
        return
    migrations_needed.append(migration)
    if not silent:
        print(colorama.Fore.RED + '[ ] ' + colorama.Style.RESET_ALL + migration.migration_name())

def restore_backup():
    backup_db()
    fetch_files()
    while len(backups):
        for i, backup in enumerate(backups):
            print(colorama.Fore.GREEN + str(i + 1) + colorama.Style.RESET_ALL + '. ' + backup)
        choice = input('Choose a number to import, or type "delete #" to delete a file.\n> ')
        if choice.isnumeric():
            choice = int(choice)
            if 0 < choice < len(backups) + 1:
                backup_file = backups[choice - 1]
                print(colorama.ansi.clear_screen())
                print(colorama.Fore.RED + 'If this is a full backup created by this tool, it is recommended to manually change \n'
                    'the DB_VER in config.yaml to the hash sequence in the filename, after \n'
                    'the database name and the timestamp, so that express update functions properly.')
                if input('Import ' + backup_file + '? [y/N] ').lower() == 'y':
                    import_file('backups/' + backup_file)
                    print(colorama.Fore.GREEN + 'Finished importing!')
                    break
            else:
                bad_selection()
        else:
            choice = re.match(r'^delete (\d+)$', choice)
            if choice:
                choice = int(choice.group(1))
                if 0 < choice < len(backups) + 1:
                    backup_file = backups[choice - 1]
                    print(colorama.ansi.clear_screen())
                    if input('Delete ' + backup_file + '? [y/N] ').lower() == 'y':
                        os.remove('../sql/backups/' + backup_file)
                        print(colorama.Fore.GREEN + 'Deleted ' + backup_file + '!')
                        fetch_files()
                else:
                    bad_selection()
            else:
                return

def reset_db():
    backup_db()
    print(colorama.Fore.RED + 'Are you sure you want to reset your database to default?')
    choice = input('Type "reset ' + database + '" to confirm.\n> ')
    choice = re.match(r'^reset (\w+)$', choice)
    if choice and choice.group(1) == database:
        setup_db()

def bad_selection():
    print(colorama.Fore.RED + 'Invalid selection.')
    time.sleep(0.5)

def menu():
    print(colorama.Fore.GREEN + 'o' + colorama.Fore.RED + '---------------------------------------' + colorama.Fore.GREEN + 'o\n' + colorama.Fore.RED +
          '| ' + colorama.Style.RESET_ALL + 'LandSandBoat Database Management Tool' + colorama.Fore.RED + ' |\n'
          '| ' + colorama.Style.RESET_ALL + str('Connected to ' + database).center(37) + colorama.Fore.RED + ' |')
    if db_ver:
        print(colorama.Fore.RED + '| ' + colorama.Style.RESET_ALL + str('#' + db_ver).center(37) + colorama.Fore.RED + ' |')
    print(colorama.Fore.GREEN + 'o' + colorama.Fore.RED + '---------------------------------------' + colorama.Fore.GREEN + 'o')
    if express_enabled:
        print(colorama.Fore.RED + '|' + colorama.Fore.GREEN + 'e' + colorama.Style.RESET_ALL + '. Express Update ' + str('(#' + release_version + ')').ljust(21) + colorama.Fore.RED + '|')
    print(colorama.Fore.RED + '|' + colorama.Fore.GREEN + '1' + colorama.Style.RESET_ALL + '. Update DB                           ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + '2' + colorama.Style.RESET_ALL + '. Check migrations                    ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + '3' + colorama.Style.RESET_ALL + '. Backup                              ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + '4' + colorama.Style.RESET_ALL + '. Restore/Import                      ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + 'r' + colorama.Style.RESET_ALL + '. Reset DB                            ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + 's' + colorama.Style.RESET_ALL + '. Settings                            ' + colorama.Fore.RED + '|\n'
          '|' + colorama.Fore.GREEN + 'q' + colorama.Style.RESET_ALL + '. Quit                                ' + colorama.Fore.RED + '|\n'
          + colorama.Fore.GREEN + 'o' + colorama.Fore.RED + '---------------------------------------' + colorama.Fore.GREEN + 'o')

def settings():
    fetch_configs()
    print(colorama.Fore.GREEN + 'Current MySQL bin location: ' + colorama.Style.RESET_ALL + mysql_bin)
    if input('Change this location? [y/N] ').lower() == 'y':
        adjust_mysql_bin()
    print(colorama.Fore.GREEN + 'Automatic backup for command line updates: ' + colorama.Style.RESET_ALL + str(bool(auto_backup)))
    if input('Change this? [y/N] ').lower() == 'y':
        adjust_auto_backup()
    print(colorama.Fore.GREEN + 'Automatic client version update for command line updates: ' + colorama.Style.RESET_ALL + str(auto_update_client))
    if input('Change this? [y/N] ').lower() == 'y':
        adjust_auto_update_client()
    write_configs()

# TODO: Hook this up to a menu option
def set_external_ip(ip_str):
    command = '"' + mysql_bin + 'mysqladmin' + exe + '" -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + \
        'UPDATE zone_settings SET zoneip = ' + ip_str + ';'
    os.system(command + log_errors)

def main():
    global mysql_bin, exe
    if fetch_credentials() == False:
        return
    fetch_configs()
    #Check MySQL path/availability
    if not os.path.exists(mysql_bin + 'mysql' + exe):
        adjust_mysql_bin()
        write_configs()
    fetch_versions()
    #CLI args
    if len(sys.argv) > 1:
        arg1 = str(sys.argv[1])
        if 'backup' == arg1:
            if len(sys.argv) > 2 and str(sys.argv[2]) == 'lite':
                backup_db(True,True)
            else:
                backup_db(True)
            return
        elif 'migrate' == arg1:
            if connect() != False:
                run_all_migrations(True)
                close()
            return
        elif 'update' == arg1:
            full_update = False
            if len(sys.argv) > 2 and str(sys.argv[2]) == 'full':
                full_update = True
            if db_ver and release_version and not express_enabled and not full_update:
                print(colorama.Fore.GREEN + 'Database is up to date.')
                return
            if connect() != False:
                if express_enabled and not full_update:
                    express_update(True)
                else:
                    update_db(True)
                close()
            return
        elif 'setup' == arg1:
            if len(sys.argv) > 2 and str(sys.argv[2]) == database:
                create_command = '"' + mysql_bin + 'mysqladmin' + exe + '" -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' CREATE ' + database
                os.system(create_command + log_errors)
                fetch_errors()
                setup_db()
            return
    #Main loop
    print(colorama.ansi.clear_screen())
    connect()
    actions = {
        '1': update_db,
        '2': run_all_migrations,
        '3': backup_db,
        '4': restore_backup,
        'r': reset_db,
        's': settings
    }
    while cur:
        menu()
        selection = input('> ').lower()
        print(colorama.ansi.clear_screen())
        if 'q' == selection:
            close()
            return
        if 'e' == selection and express_enabled:
            express_update()
            continue
        useTool = actions.get(selection, bad_selection)
        useTool()

if __name__ == '__main__':
    main()
