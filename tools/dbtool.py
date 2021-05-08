# Internal Deps
import os
import subprocess
import sys
import re
import time
import fileinput
import distutils.spawn

# Pre-flight sanity checks
def preflight_exit():
    # If double clicked on Windows: pause with an input so the user can read the error...
    if os.name == 'nt' and 'PROMPT' not in os.environ:
        input('Press ENTER to continue...')
    exit(-1)

# - git should be on the user's PATH
if not 'git' in os.environ['PATH'].lower():
    print("ERROR: Make sure git.exe is available in your system's PATH environment variable.")
    preflight_exit()

# - dbtool.py is designed to be run from <root>/tools folder, not <root>
if not os.path.isfile("./dbtool.py"):
    print("ERROR: dbtool.py is designed to be run from <root>/tools folder, not <root>. Please run from the tools folder.")
    preflight_exit()

# - Repo should be checked out as a git repo, not as plain files
if not subprocess.call(['git', '-C', "../", 'status'], stderr=subprocess.STDOUT, stdout = open(os.devnull, 'w')) == 0:
    print("ERROR: The project must be checked out as a git repo (using git clone, or similar).")
    preflight_exit()

# External Deps (requirements.txt)
try:
    import mysql.connector
    from mysql.connector import Error, errorcode
    from git import Repo
    import yaml
    import colorama
    from colorama import Fore, Style
except Exception as e:
    print("ERROR: Exception occured while importing external dependencies:")
    print(e)
    preflight_exit()

# Migrations
from migrations import spell_blobs_to_spell_table
from migrations import unnamed_flags
from migrations import char_unlock_table_columns
from migrations import HP_masks_to_blobs
from migrations import crystal_storage
from migrations import broken_linkshells
from migrations import spell_family_column
from migrations import mission_blob_extra
from migrations import cop_mission_ids
from migrations import add_daily_tally_column
from migrations import add_timecreated_column
from migrations import extend_mission_log
from migrations import eminence_blob
from migrations import char_timestamp
from migrations import currency_columns
from migrations import add_instance_zone_column
from migrations import convert_all_tables_to_innodb
from migrations import char_points_weekly_unity
from migrations import char_profile_unity_leader
from migrations import convert_mission_status
from migrations import convert_zilart_status
from migrations import add_job_master_column_chars
from migrations import currency2

# Append new migrations to this list and import above
migrations = [
    unnamed_flags,
    spell_blobs_to_spell_table,
    char_unlock_table_columns,
    HP_masks_to_blobs,
    crystal_storage,
    broken_linkshells,
    spell_family_column,
    extend_mission_log,
    mission_blob_extra,
    cop_mission_ids,
    add_daily_tally_column,
    add_timecreated_column,
    eminence_blob,
    char_timestamp,
    currency_columns,
    add_instance_zone_column,
    convert_all_tables_to_innodb,
    char_points_weekly_unity,
    char_profile_unity_leader,
    convert_mission_status,
    convert_zilart_status,
    add_job_master_column_chars,
    currency2,
]

# These are the default 'protected' files
player_data = [
    'accounts.sql',
    'accounts_banned.sql',
    'auction_house.sql',
    'char_blacklist.sql',
    'char_effects.sql',
    'char_equip.sql',
    'char_exp.sql',
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
    'linkshells.sql',
    'server_variables.sql',
    'unity_system.sql',
]
import_files = []
backups = []
database = host = port = login = password = None
db = cur = None
repo = Repo('../')
current_version = current_client = release_version = release_client = None
express_enabled = False
auto_backup = auto_update_client = True
mysql_bin = ''
mysql_env = distutils.spawn.find_executable('mysql')
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
                print(Fore.RED + line)
        os.remove('error.log')
    except:
        return

def fetch_credentials():
    global database, host, port, login, password
    credentials = {}

    # Grab mysql credentials
    filename = '../conf/map.conf'
    try:
        with open(filename) as f:
            while True:
                line = f.readline()
                if not line: break
                match = re.match(r'(mysql_\w+):\s+(\S+)', line)
                if match:
                    credentials[match.group(1)] = match.group(2)
        database = os.getenv('XI_DB_NAME') or credentials['mysql_database']
        host = os.getenv('XI_DB_HOST') or credentials['mysql_host']
        port = os.getenv('XI_DB_PORT') or int(credentials['mysql_port'])
        login = os.getenv('XI_DB_USER') or credentials['mysql_login']
        password = os.getenv('XI_DB_USER_PASSWD') or credentials['mysql_password']
    except:
        print(Fore.RED + 'Error fetching credentials.\nCheck ../conf/map.conf.')
        return False

def fetch_versions():
    global current_version, current_client, release_version, release_client
    current_version = current_client = release_version = release_client = None
    try:
        release_version = repo.git.rev_parse(repo.head.object.hexsha, short=4)
    except:
        print(Fore.RED + 'Unable to read current version hash.')
    try:
        with open('../conf/default/version.conf') as f:
            while True:
                line = f.readline()
                if not line: break
                match = re.match(r'\S?CLIENT_VER:\s+(\S+)', line)
                if match:
                    release_client = match.group(1)
    except:
        print(Fore.RED + 'Unable to read ../conf/default/version.conf.')
    try:
        with open('../conf/version.conf') as f:
            while True:
                line = f.readline()
                if not line: break
                match = re.match(r'\S?DB_VER:\s+(\S+)', line)
                if match:
                    current_version = match.group(1)
                else:
                    match = re.match(r'\S?CLIENT_VER:\s+(\S+)', line)
                    if match:
                        current_client = match.group(1)
    except:
        print(Fore.RED + 'Unable to read ../conf/version.conf.')
    if current_version and release_version:
        fetch_files(True)
    else:
        fetch_files()

def fetch_configs():
    global player_data, mysql_bin, auto_backup, auto_update_client
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
                    if key == 'player_data':
                        player_data = value
    except:
        write_configs()

def write_configs():
    with open(r'config.yaml', 'w') as file:
        dump = [{'mysql_bin' : mysql_bin}, {'auto_backup' : auto_backup}, {'auto_update_client' : auto_update_client},{'player_data' : player_data}]
        yaml.dump(dump, file)

def fetch_files(express=False):
    import_files.clear()
    if express:
        try:
            global express_enabled
            sql_diffs = repo.commit(current_version).diff(release_version,paths='sql/')
            if len(sql_diffs) > 0:
                for diff in sql_diffs:
                    import_files.append(diff.a_path[4:])
                express_enabled = True
            else:
                express_enabled = False
                if len(repo.commit(current_version).diff(release_version,paths='tools/migrations')) > 0:
                    express_enabled = True
        except:
            print(Fore.RED + 'Error checking diffs.\nCheck that hash is valid in ../conf/version.conf.')
    else:
        for (_, _, filenames) in os.walk('../sql/'):
            import_files.extend(filenames)
            break
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
    except:
        return

def write_version(silent=False):
    success = False
    update_client = auto_update_client
    if not silent and current_client != release_client:
        update_client = input('Update client version? [y/N] ').lower() == 'y'
    update_client = update_client and release_client
    try:
        for line in fileinput.input('../conf/version.conf', inplace=True):
            match = re.match(r'\S?DB_VER:\s+(\S+)', line)
            if match:
                success = True
                line = '#DB_VER: ' + release_version
            elif update_client:
                if current_client != release_client:
                    match = re.match(r'\S?CLIENT_VER:\s+(\S+)', line)
                    if match:
                        line = 'CLIENT_VER: ' + release_client + '\n'
                else:
                    update_client = False
            print(line, end='')
        if not success:
            with open('../conf/version.conf', 'a') as vfile:
                vfile.write('\n#DB_VER: ' + release_version)
        if update_client:
            print(Fore.GREEN + 'Updated client version!')
        fetch_versions()
    except:
        fileinput.close()
        print(Fore.RED + 'Error writing version.')

def import_file(file):
    print('Importing ' + file + '...')
    result = subprocess.run([
        '{}mysql{}'.format(mysql_bin, exe),
        '-h', host,
        '-P', str(port),
        '-u', login,
        '-p{}'.format(password),
        database,
        '-e', 'SET autocommit=0; SET unique_checks=0; SET foreign_key_checks=0; source ../sql/{}; SET unique_checks=1; SET foreign_key_checks=1; COMMIT;'.format(file)],
        capture_output=True, text=True)

    for line in result.stderr.splitlines():
        # Safe to ignore this warning
        if 'Using a password on the command line interface can be insecure' not in line:
            print(Fore.RED + line)

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
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print(Fore.RED + 'Incorrect mysql_login or mysql_password, update ../conf/map.conf.')
            close()
            return False
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print(Fore.RED + 'Database ' + database + ' does not exist.')
            if input('Would you like to create new database: ' + database + '? [y/N] ').lower() == 'y':
                create_command = '"' + mysql_bin + 'mysqladmin' + exe + '" -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' CREATE ' + database
                os.system(create_command + log_errors)
                fetch_errors()
                setup_db()
                connect()
        else:
            print(Fore.RED + err)
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
    print(Fore.GREEN + 'Finished importing!')
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
            if current_version:
                dumpcmd = '"' + mysql_bin + 'mysqldump' + exe + '" --hex-blob --add-drop-trigger -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' ' + database +\
                    ' > ../sql/backups/' + database + '-' + time.strftime('%Y%m%d-%H%M%S') + '-' + current_version + '.sql'
            else:
                dumpcmd = '"' + mysql_bin + 'mysqldump' + exe + '" --hex-blob --add-drop-trigger -h ' + host + ' -P ' + str(port) + ' -u ' + login + ' -p' + password + ' ' + database +\
                    ' > ../sql/backups/' + database + time.strftime('%Y%m%d-%H%M%S') + '-full.sql'
        os.system(dumpcmd + log_errors)
        fetch_errors()
        print(Fore.GREEN + 'Database saved!')
        time.sleep(0.5)

def express_update(silent=False):
    update_db(silent, True)

def update_db(silent=False,express=False):
    if not silent or auto_backup:
        backup_db(silent, auto_backup == 2)
    if not express:
        fetch_files()
    if not silent:
        print(Fore.GREEN + 'The following files will be imported:')
        for sql_file in import_files:
            if sql_file not in player_data:
                print(sql_file)
    if silent or input('Proceed with update? [y/N] ').lower() == 'y':
        for sql_file in import_files:
            if sql_file not in player_data:
                import_file(sql_file)
        print(Fore.GREEN + 'Finished importing!')
        run_all_migrations(silent or express)
        write_version(silent)

def adjust_mysql_bin():
    global mysql_bin
    while True:
        choice = input('Please enter the path to your MySQL bin directory or press enter to check PATH.\ne.g. C:\\Program Files\\MariaDB 10.5\\bin\\\n> ').replace('\\', '/')
        if choice == '':
            mysql_file = distutils.spawn.find_executable('mysql')
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
                auto_backup = True
                break
        elif choice == 'n':
            auto_backup = False
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

def adjust_imports():
    while True:
        print(Fore.GREEN + 'The following files are marked as protected and will not be imported:')
        for i, safe_file in enumerate(player_data):
            print(Fore.GREEN + str(i + 1) + Style.RESET_ALL + '. ' + safe_file)
        choice = input('Choose a number to remove it from this list, or type a file name to include it.\n> ')
        if not choice:
            return
        if choice.isnumeric() and 0 < int(choice) <= len(player_data):
            player_data.pop(int(choice) - 1)
        else:
            player_data.append(choice)

def run_all_migrations(silent=False):
    migrations_needed = []
    print(Fore.GREEN + 'Checking migrations...')
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
        print(Fore.GREEN + 'Finished migrations!')
        if os.path.exists('migration_errors.log'):
            print(Fore.RED + 'There were errors with some migrations, this likely means one or more characters \n'
                'have corrupt data in some field. See migration_errors.log for more details.')
        time.sleep(0.5)
    else:
        print(Fore.GREEN + 'No migrations required.')
        time.sleep(0.5)

def check_migration(migration, migrations_needed, silent=False):
    migration.check_preconditions(cur)
    if not migration.needs_to_run(cur):
        if not silent:
            print(Fore.RED + '[' + Fore.GREEN + '*' + Fore.RED + '] ' + Style.RESET_ALL + migration.migration_name())
        return
    migrations_needed.append(migration)
    if not silent:
        print(Fore.RED + '[ ] ' + Style.RESET_ALL + migration.migration_name())

def restore_backup():
    backup_db()
    fetch_files()
    while len(backups):
        for i, backup in enumerate(backups):
            print(Fore.GREEN + str(i + 1) + Style.RESET_ALL + '. ' + backup)
        choice = input('Choose a number to import, or type "delete #" to delete a file.\n> ')
        if choice.isnumeric():
            choice = int(choice)
            if 0 < choice < len(backups) + 1:
                backup_file = backups[choice - 1]
                print(colorama.ansi.clear_screen())
                print(Fore.RED + 'If this is a full backup created by this tool, it is recommended to manually change \n'
                    'the DB_VER in ../conf/version.conf to the hash sequence in the filename, after \n'
                    'the database name and the timestamp, so that express update functions properly.')
                if input('Import ' + backup_file + '? [y/N] ').lower() == 'y':
                    import_file('backups/' + backup_file)
                    print(Fore.GREEN + 'Finished importing!')
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
                        print(Fore.GREEN + 'Deleted ' + backup_file + '!')
                        fetch_files()
                else:
                    bad_selection()
            else:
                return

def reset_db():
    backup_db()
    print(Fore.RED + 'Are you sure you want to reset your database to default?')
    choice = input('Type "reset ' + database + '" to confirm.\n> ')
    choice = re.match(r'^reset (\w+)$', choice)
    if choice and choice.group(1) == database:
        setup_db()

def bad_selection():
    print(Fore.RED + 'Invalid selection.')
    time.sleep(0.5)

def menu():
    print(Fore.GREEN + 'o' + Fore.RED + '--------------------------------' + Fore.GREEN + 'o\n' + Fore.RED + 
          '| ' + Style.RESET_ALL + 'Topaz Database Management Tool ' + Fore.RED + '|\n'
          '| ' + Style.RESET_ALL + str('Connected to ' + database).center(30) + Fore.RED + ' |')
    if current_version:
        print(Fore.RED + '| ' + Style.RESET_ALL + str('#' + current_version).center(30) + Fore.RED + ' |')
    print(Fore.GREEN + 'o' + Fore.RED + '--------------------------------' + Fore.GREEN + 'o')
    if express_enabled: 
        print(Fore.RED + '|' + Fore.GREEN + 'e' + Style.RESET_ALL + '. Express Update ' + str('(#' + release_version + ')').ljust(14) + Fore.RED + '|')
    print(Fore.RED + '|' + Fore.GREEN + '1' + Style.RESET_ALL + '. Update DB                    ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + '2' + Style.RESET_ALL + '. Check migrations             ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + '3' + Style.RESET_ALL + '. Backup                       ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + '4' + Style.RESET_ALL + '. Restore/Import               ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + 'r' + Style.RESET_ALL + '. Reset DB                     ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + 's' + Style.RESET_ALL + '. Settings                     ' + Fore.RED + '|\n'
          '|' + Fore.GREEN + 'q' + Style.RESET_ALL + '. Quit                         ' + Fore.RED + '|\n'
          + Fore.GREEN + 'o' + Fore.RED + '--------------------------------' + Fore.GREEN + 'o')

def settings():
    fetch_configs()
    print(Fore.GREEN + 'Current MySQL bin location: ' + Style.RESET_ALL + mysql_bin)
    if input('Change this location? [y/N] ').lower() == 'y':
        adjust_mysql_bin()
    print(Fore.GREEN + 'Automatic backup for command line updates: ' + Style.RESET_ALL + str(bool(auto_backup)))
    if input('Change this? [y/N] ').lower() == 'y':
        adjust_auto_backup()
    print(Fore.GREEN + 'Automatic client version update for command line updates: ' + Style.RESET_ALL + str(auto_update_client))
    if input('Change this? [y/N] ').lower() == 'y':
        adjust_auto_update_client()
    adjust_imports()
    write_configs()

def main():
    global mysql_bin, exe
    if fetch_credentials() == False:
        return
    fetch_versions()
    fetch_configs()
    #Check MySQL path/availability
    if not os.path.exists(mysql_bin + 'mysql' + exe):
        adjust_mysql_bin()
        write_configs()
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
            if current_version and release_version and not express_enabled and not full_update:
                print(Fore.GREEN + 'Database is up to date.')
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
