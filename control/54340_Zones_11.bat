@echo off
title Zone 11 - Tavnazian Archipelago
cd ..
:onCrash
echo [%date% %time%] Restarting Tavnazian Archipelago...
xi_map.exe --ip 96.236.43.244 --port 54340 --log log\Zones_11.txt
echo ...
GOTO onCrash