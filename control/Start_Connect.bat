@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Lobby/Connection Server...
xi_connect.exe
echo ...
GOTO onCrash