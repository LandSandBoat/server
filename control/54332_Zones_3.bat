@echo off
title Zone 3 - Ronfaure, Zulkheim
cd ..
:onCrash
echo [%date% %time%] Restarting Battlefields Map Server...
xi_map.exe --ip 96.236.43.244 --port 54332
echo ...
GOTO onCrash