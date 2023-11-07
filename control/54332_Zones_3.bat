@echo off
title Zone 3 - Ronfaure, Zulkheim
cd ..
:onCrash
echo [%date% %time%] Restarting Ronfaure, Zulkheim...
xi_map.exe --ip 96.236.43.244 --port 54332 --log log\Zones_3.txt
echo ...
GOTO onCrash