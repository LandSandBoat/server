@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Lobby/Connection Server...
topaz_connect_64.exe
echo ...
GOTO onCrash