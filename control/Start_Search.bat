@echo off
title Search Server
cd ..
:onCrash
echo [%date% %time%] Restarting Search Server...
xi_search.exe
echo ...
GOTO onCrash