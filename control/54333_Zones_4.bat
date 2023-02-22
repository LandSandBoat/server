@echo off
title Zone 4 Valdeaunia, Fauregandi
cd ..
:onCrash
echo [%date% %time%] Restarting Zone 4 Valdeaunia, Fauregandi...
xi_map.exe --ip 96.236.43.244 --port 54333 --log log\Zones_4.txt
echo ...
GOTO onCrash