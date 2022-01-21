@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Cities Map Server...
topaz_game_64.exe --ip 10.0.0.236 --port 54230
echo ...
GOTO onCrash