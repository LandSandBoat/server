@echo off
title Connect Server
cd ..
:onCrash
echo [%date% %time%] Restarting Lobby/Connection Server...
timeout /t 5 >null
start xi_connect.exe
echo ...
GOTO onCrash