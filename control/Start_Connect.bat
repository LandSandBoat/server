@echo off
title Connect Server
cd ..
:onCrash
echo [%date% %time%] Restarting Lobby/Connection Server...
start xi_connect.exe
timeout /t 3600 >null
taskkill /f /im xi_connect.exe >null
echo ...
GOTO onCrash