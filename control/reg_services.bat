@echo off
set serverPath="c:\catseyexi"
set /p serverPath="Please enter path to lsb executables (default - %serverPath%): "
%~dp0\bin\nssm.exe install map_cluster_1 %serverPath%\topaz_game_64.exe
%~dp0\bin\nssm.exe install map_cluster_2 %serverPath%\topaz_game_64_2.exe --port 54231
%~dp0\bin\nssm.exe install map_cluster_3 %serverPath%\topaz_game_64_3.exe --port 54232
%~dp0\bin\nssm.exe install map_cluster_4 %serverPath%\topaz_game_64_4.exe --port 54233
%~dp0\bin\nssm.exe install map_cluster_5 %serverPath%\topaz_game_64_5.exe --port 54234
%~dp0\bin\nssm.exe install map_cluster_6 %serverPath%\topaz_game_64_6.exe --port 54235
%~dp0\bin\nssm.exe install topaz_connect_64 %serverPath%\topaz_connect_64.exe
%~dp0\bin\nssm.exe install topaz_search_64 %serverPath%\topaz_search_64.exe
pause