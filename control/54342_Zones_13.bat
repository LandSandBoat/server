@echo off
title Zone 13 - No Go Zones
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54342
echo ...
GOTO onCrash