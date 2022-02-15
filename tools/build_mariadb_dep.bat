REM WINDOWS ONLY SCRIPT!
REM For building our external dependency DLLs
REM To be run from /tools/ directory
REM Change TYPE between Debug/Release, if you like

SET TYPE=Release

git clone --depth 1 --branch 3.1.10 https://github.com/mariadb-corporation/mariadb-connector-c.git

mkdir mariadb-connector-c\build32
mkdir mariadb-connector-c\build64

cmake -A Win32 -S mariadb-connector-c -B "mariadb-connector-c\build32"
cmake -S mariadb-connector-c -B "mariadb-connector-c\build64"

cmake --build mariadb-connector-c\build32 --config %TYPE% --target package
cmake --build mariadb-connector-c\build64 --config %TYPE% --target package

REM You can now extract the packaged outputs of these two builds to:
REM ext/mariadb32
REM ext/mariadb64
