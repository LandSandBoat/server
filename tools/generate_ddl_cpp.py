# Run from <root>/tools/ directory

import subprocess
import os

MYSQL_DUMP_EXE="C:/Program Files/MariaDB 10.5/bin/mysqldump.exe"
DDL2CPP_SCRIPT="C:/ffxi/server/build/_deps/sqlpp11-src/scripts/ddl2cpp"
CLANG_FORMAT_EXE="clang-format"

def main():
    # Generate DDL
    output = subprocess.run([MYSQL_DUMP_EXE, "-uroot", "-proot", "--no-data", "xidb"], stdout=subprocess.PIPE).stdout.decode('utf-8')

    with open("xidb.sql", "w") as f:
        f.write(output)

    # Use DDL with ddl2cpp to generate cpp
    subprocess.run(["python", DDL2CPP_SCRIPT, "-split-tables", "xidb.sql", "../src/database", "xidb"])

    os.remove("xidb.sql")

    # TODO: Format output
    subprocess.run([CLANG_FORMAT_EXE, "-i", "*.h"])

    # TODO: Fix these
    # Warning: timestamp is mapped to sqlpp::time_point like datetime
    # Warning: You have to take care of timezones yourself
    # You can disable this warning using -no-timestamp-warning
    # Error: datatype "binary"" is not supported.
    # Error: datatype "tinytext"" is not supported.
    # Error: datatype "float unsigned"" is not supported.
    # Error: datatype "varbinary"" is not supported.

    # Add to ddl2cpp map:
    # 'tinytext' : 'text', #MYSQL
    # 'binary' : 'blob', #MYSQL
    # 'varbinary' : 'blob', #MYSQL
    # 'float unsigned' : 'floating_point', #MYSQL

if __name__ == "__main__":
    main()
