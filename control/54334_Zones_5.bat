@echo off
title Zone 5 Qufim, Norvallen
cd ..
:onCrash
echo [%date% %time%] Restarting Zone 5 Qufim, Norvallen...
xi_map.exe --ip 96.236.43.244 --port 54334 --log log\Zones_5.txt
echo ...
GOTO onCrash