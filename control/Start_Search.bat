@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Search Server...
topaz_Search_64.exe
echo ...
GOTO onCrash