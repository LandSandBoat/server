@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Fields Map Server...
topaz_game_64.exe --ip 71.164.90.4 --port 54332
echo ...
GOTO onCrash