REM WINDOWS ONLY SCRIPT!
REM For building our external dependency DLLs
REM To be run from /tools/ directory
REM Change TYPE between Debug/Release, if you like

SET TYPE=Release

git clone --branch 3.1.10 --depth 1 https://github.com/mariadb-corporation/mariadb-connector-c.git

mkdir mariadb-connector-c\build32
mkdir mariadb-connector-c\build64

cmake -A Win32 -S mariadb-connector-c -B "mariadb-connector-c\build32"
cmake -S mariadb-connector-c -B "mariadb-connector-c\build64"

cmake --build mariadb-connector-c\build32 --config %TYPE% --target package
cmake --build mariadb-connector-c\build64 --config %TYPE% --target package

for /R "mariadb-connector-c\build32" %%I in ("*.zip") do (
    tar -xf %%I -C ../ext/mariadb32/ --strip-components=1
)

for /R "mariadb-connector-c\build64" %%I in ("*.zip") do (
    tar -xf %%I -C ../ext/mariadb64/ --strip-components=1
)
