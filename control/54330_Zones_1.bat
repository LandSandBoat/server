@echo off
title Zone 1 - Kuzotz, Volbow
cd ..
:onCrash
echo [%date% %time%] Restarting Dungeons Map Server...
xi_map.exe --ip 96.236.43.244 --port 54330
echo ...
GOTO onCrash