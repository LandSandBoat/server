@echo off
echo Starting game server processes ...
pause
%~dp0\bin\nssm.exe start map_cluster_1
rem %~dp0\bin\nssm.exe start map_cluster_2
rem %~dp0\bin\nssm.exe start map_cluster_3
rem %~dp0\bin\nssm.exe start map_cluster_4
rem %~dp0\bin\nssm.exe start map_cluster_5
rem %~dp0\bin\nssm.exe start map_cluster_6
%~dp0\bin\nssm.exe start topaz_connect_64
%~dp0\bin\nssm.exe start topaz_search_64
pause