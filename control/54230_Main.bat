@echo off
title Mog House, Korroloka Tunnel
cd ..
:onCrash
echo [%date% %time%] Restarting Cities Map Server...
xi_map.exe --ip 96.236.43.244 --port 54230 --log log\Zone_0.txt
echo ...
GOTO onCrash