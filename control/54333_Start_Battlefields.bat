@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Battlefields Map Server...
topaz_game_64.exe --ip 10.0.0.236 --port 54333
echo ...
GOTO onCrash