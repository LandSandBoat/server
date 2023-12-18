REM Run from repo root
REM Uses clang-format-14

for /r %cd%\src\ %%f in (*.cpp) do clang-format -style=file -i %%f
for /r %cd%\src\ %%f in (*.h) do clang-format -style=file -i %%f
for /r %cd%\modules\ %%f in (*.cpp) do clang-format -style=file -i %%f
for /r %cd%\modules\ %%f in (*.h) do clang-format -style=file -i %%f
