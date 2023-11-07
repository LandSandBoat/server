@echo off
title Zone 7 - Elshimo Uplands, Elshimo Lowlands
cd ..
:onCrash
echo [%date% %time%] Restarting Elshimo Uplands, Elshimo Lowlands...
xi_map.exe --ip 96.236.43.244 --port 54336 --log log\Zones_7.txt
echo ...
GOTO onCrash