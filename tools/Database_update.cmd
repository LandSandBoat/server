@echo off

:IMPORTFOLDERID
set /p importfolderid=Enter the path to your folder for import:
cls


echo FOLDER PATH YOU ENTERED IS = %importfolderid%
echo Please type Y for Yes - N for No - T for Terminate

set /p answer=IS THIS CORRECT (Y/N/T)?
if /i "%answer:~,1%" EQU "Y" goto IMPORTER
if /i "%answer:~,1%" EQU "N" goto IMPORTFOLDERID
if /i "%answer:~,1%" EQU "T" goto END

:IMPORTER

pushd %importfolderid%
if %errorlevel% NEQ 0 (
    echo Folder path %importfolderid% not found, please update path and retry
    goto END
)

set month=%DATE:~4,2%
set day=%DATE:~7,2%
set year=%DATE:~10,4%
set hour=%TIME:~0,2%
set min=%TIME:~3,2%

set importtime=%month%-%day%-%year%-%hour%-%min%
echo %importtime%

REM may need to change the path to mysql
set mysql="C:\Program Files\MariaDB 10.4\bin\mysql.exe"
if not exist %mysql% (
    echo mysql not found at %mysql%, please update path and retry
    goto END
)
set dbhost=localhost
set dbuser=root

:dbpassset

set /p dbpass=Enter the database password:
cls


echo Password you entered is = %dbpass%
echo Please type Y for Yes - N for No - T for Terminate

set /p answer=IS THIS CORRECT (Y/N/T)?
if /i "%answer:~,1%" EQU "Y" goto databaseset
if /i "%answer:~,1%" EQU "N" goto dbpassset
if /i "%answer:~,1%" EQU "T" goto END

:databaseset

set /p database=Enter the database name:
cls

echo Database you entered is = %database%
echo Please type Y for Yes - N for No - T for Terminate

set /p answer=IS THIS CORRECT (Y/N/T)?
if /i "%answer:~,1%" EQU "Y" goto IMPORTER2
if /i "%answer:~,1%" EQU "N" goto dbpassset
if /i "%answer:~,1%" EQU "T" goto END

:IMPORTER2

ECHO Loading %database% tables into the database

for %%S in (abilities*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (augments.sql) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (automaton*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (b*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (conquest*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (despoil*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (exp*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (f*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (g*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (h*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (i*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (j*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (m*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (n*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (p*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (skill*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (spell*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (status*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (synth*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (t*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (w*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S
for %%S in (z*) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S

:END

popd
pause
exit