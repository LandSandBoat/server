@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

rem 共通ファイルの正本パスを定義する
set "SOURCE_AGENTS=D:\program\workspace-meta\AGENTS.md"
set "SOURCE_GLOBAL_CHANGES=D:\program\workspace-meta\GLOBAL_CHANGES.md"

rem このバッチを配置したフォルダへシンボリックリンクを作成する
rem シンボリックリンク作成には管理者権限が必要です。
call :create_symlink "%SOURCE_AGENTS%" "%SCRIPT_DIR%\AGENTS.md"
if errorlevel 1 exit /b 1

call :create_symlink "%SOURCE_GLOBAL_CHANGES%" "%SCRIPT_DIR%\GLOBAL_CHANGES.md"
if errorlevel 1 exit /b 1

echo.
echo [OK] Symbolic links created successfully.
echo.
pause
exit /b 0

:create_symlink
set "SOURCE_FILE=%~1"
set "DEST_FILE=%~2"

echo.
echo [INFO] source : "%SOURCE_FILE%"
echo [INFO] dest   : "%DEST_FILE%"
echo.

if not exist "%SOURCE_FILE%" (
  echo [ERROR] source file was not found.
  pause
  exit /b 1
)

if exist "%DEST_FILE%" (
  echo [STOP] destination already exists. delete it and run again.
  echo Path: "%DEST_FILE%"
  pause
  exit /b 1
)

rem mklink (without /H) creates a symbolic link
mklink "%DEST_FILE%" "%SOURCE_FILE%" >nul
if errorlevel 1 (
  echo [ERROR] failed to create symbolic link. 
  echo (Note: Standard users might need Developer Mode or Administrator privileges)
  pause
  exit /b 1
)

exit /b 0
