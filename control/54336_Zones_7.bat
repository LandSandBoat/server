@echo off
title Zone 7 - Elshimo Uplands, Elshimo Lowlands
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54336
echo ...
GOTO onCrash