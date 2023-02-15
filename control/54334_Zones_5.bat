@echo off
title Zone 5 Qufim, Norvallen
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54334
echo ...
GOTO onCrash