@echo off
title Zone 6 - Argoneau, LiTelor, Kolshushu, Sarutabaruta
cd ..
:onCrash
echo [%date% %time%] Restarting Dynamis Map Server...
xi_map.exe --ip 96.236.43.244 --port 54335
echo ...
GOTO onCrash