@echo off

:IMPORTFOLDERID
set /p importfolderid=Enter the path to your folder for import:
cls


echo FOLDER PATH YOU ENTERED IS = %importfolderid%
echo Please type Y for Yes - N for No - T for Terminate

set /p answer=IS THIS CORRECT (Y/N/T)?
if /i "%answer:~,1%" EQU "Y" goto IMPORTER
if /i "%answer:~,1%" EQU "N" goto IMPORTFOLDERID
if /i "%answer:~,1%" EQU "T" EXIT

cd %importfolderid%
cd


:IMPORTER

set month=%DATE:~4,2%
set day=%DATE:~7,2%
set year=%DATE:~10,4%
set hour=%TIME:~0,2%
set min=%TIME:~3,2%

set importtime=%month%-%day%-%year%-%hour%-%min%
echo %importtime%

REM may need to change the path to mysql and mysqladmin
set mysql="C:\Program Files\MariaDB 10.4\bin\mysql.exe"
set mysqladmin="C:\Program Files\MariaDB 10.4\bin\mysqladmin.exe"
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
if /i "%answer:~,1%" EQU "T" EXIT

:databaseset

set /p database=Enter the database name:
cls

echo Database you entered is = %database%
echo Please type Y for Yes - N for No - T for Terminate

set /p answer=IS THIS CORRECT (Y/N/T)?
if /i "%answer:~,1%" EQU "Y" goto IMPORTER2
if /i "%answer:~,1%" EQU "N" goto dbpassset
if /i "%answer:~,1%" EQU "T" EXIT

:IMPORTER2
cd %importfolderid%
cd

ECHO Dropping Database %database%
%mysqladmin% -h %dbhost% -u %dbuser% -p%dbpass% DROP %database%

ECHO Creating Database %database%
%mysqladmin% -h %dbhost% -u %dbuser% -p%dbpass% CREATE %database%

ECHO Loading %database% tables into the database
for %%S in (*.sql) DO ECHO Importing %%S & %mysql% --host=%dbhost% --user=%dbuser% --password=%dbpass% --database=%database% < %%S

pause
exit