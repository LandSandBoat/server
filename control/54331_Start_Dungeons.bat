@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Dungeons Map Server...
topaz_game_64.exe --ip 71.164.90.4 --port 54331
echo ...
GOTO onCrash