@echo off
set serverPath="c:\catseyexi"
set /p serverPath="Please enter the PATH for the map server executables [default - C:\catseyexi\]: "
copy %serverPath%\topaz_game_64.exe %serverPath%\topaz_game_64_2.exe
copy %serverPath%\topaz_game_64.exe %serverPath%\topaz_game_64_3.exe
copy %serverPath%\topaz_game_64.exe %serverPath%\topaz_game_64_4.exe
copy %serverPath%\topaz_game_64.exe %serverPath%\topaz_game_64_5.exe
copy %serverPath%\topaz_game_64.exe %serverPath%\topaz_game_64_6.exe
pause