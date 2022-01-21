@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting No-Go Map Server...
topaz_game_64.exe --ip 10.0.0.236 --port 54335
echo ...
GOTO onCrash