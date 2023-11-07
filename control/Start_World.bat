@echo off
title World Server
cd ..
:onCrash
echo [%date% %time%] Restarting World Server...
xi_world.exe
echo ...
GOTO onCrash