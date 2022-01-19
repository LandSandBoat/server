@echo off
set serverPath="c:\catseyexi"
set /p serverPath="Please enter path to lsb executables (default - %serverPath%): "
%~dp0\bin\nssm.exe install map_cluster_1 %serverPath%\topaz_game_64.exe --ip 71.164.90.4 --port 54230
%~dp0\bin\nssm.exe install map_cluster_2 %serverPath%\topaz_game_64_2.exe --ip 71.164.90.4 --port 54331
%~dp0\bin\nssm.exe install map_cluster_3 %serverPath%\topaz_game_64_3.exe --ip 71.164.90.4 --port 54332
%~dp0\bin\nssm.exe install map_cluster_4 %serverPath%\topaz_game_64_4.exe --ip 71.164.90.4 --port 54333
%~dp0\bin\nssm.exe install map_cluster_5 %serverPath%\topaz_game_64_5.exe --ip 71.164.90.4 --port 54334
%~dp0\bin\nssm.exe install map_cluster_6 %serverPath%\topaz_game_64_6.exe --ip 71.164.90.4 --port 54335
%~dp0\bin\nssm.exe install topaz_connect_64 %serverPath%\topaz_connect_64.exe
%~dp0\bin\nssm.exe install topaz_search_64 %serverPath%\topaz_search_64.exe
pause