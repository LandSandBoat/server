@echo off
cd ..
:onCrash
echo [%date% %time%] Restarting Dungeons Map Server...
topaz_game_64.exe --ip 10.0.0.236 --port 54331
echo ...
GOTO onCrash