@echo off
echo Removing game server services ...
pause
%~dp0\bin\nssm.exe remove map_cluster_1
%~dp0\bin\nssm.exe remove map_cluster_2
%~dp0\bin\nssm.exe remove map_cluster_3
%~dp0\bin\nssm.exe remove map_cluster_4
%~dp0\bin\nssm.exe remove map_cluster_5
%~dp0\bin\nssm.exe remove map_cluster_6
%~dp0\bin\nssm.exe remove topaz_connect_64
%~dp0\bin\nssm.exe remove topaz_search_64
pause