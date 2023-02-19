@echo off
title Zone 8 - Tu'Lia (Sky)
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54337 --log log\Zones_8.txt
echo ...
GOTO onCrash