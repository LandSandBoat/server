@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Cities Map Server...
rem topaz_game_64.exe --ip 71.164.90.4 --port 54230
topaz_game_64.exe
echo ...
GOTO onCrash