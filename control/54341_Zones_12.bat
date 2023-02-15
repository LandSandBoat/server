@echo off
title Zone 12 - Dynamis, Abyssea
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54341
echo ...
GOTO onCrash