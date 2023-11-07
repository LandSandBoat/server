@echo off
title Zone 10 - Wings of the Goddess
cd ..
:onCrash
echo [%date% %time%] Restarting Wings of the Goddess...
xi_map.exe --ip 96.236.43.244 --port 54339 --log log\Zones_10.txt
echo ...
GOTO onCrash