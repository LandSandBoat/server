@echo off
title Zone 2 - Derfland, Gustaberg
cd ..
:onCrash
echo [%date% %time%] Restarting Fields Map Server...
xi_map.exe --ip 96.236.43.244 --port 54331
echo ...
GOTO onCrash