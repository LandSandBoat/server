@echo off
title Zone 11 - Tavnazian Archipelago
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54340
echo ...
GOTO onCrash