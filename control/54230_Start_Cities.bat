@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Cities Map Server...
topaz_game_64.exe --ip 71.164.90.4 --port 54230
echo ...
GOTO onCrash