@echo off
title Zone 10 - Wings of the Goddess
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54339
echo ...
GOTO onCrash