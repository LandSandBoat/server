@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Fields Map Server...
topaz_game_64.exe --ip 10.0.0.236 --port 54332
echo ...
GOTO onCrash