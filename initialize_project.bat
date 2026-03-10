@echo off
setlocal

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

set "META_ROOT=D:\program\workspace-meta"
set "INIT_SCRIPT=%META_ROOT%\create_project.py"

echo.
echo [INFO] project root : "%SCRIPT_DIR%"
echo [INFO] init script  : "%INIT_SCRIPT%"
echo.

if not exist "%INIT_SCRIPT%" (
  echo [ERROR] create_project.py was not found.
  echo [ERROR] expected: "%INIT_SCRIPT%"
  pause
  exit /b 1
)

python "%INIT_SCRIPT%" --project-root "%SCRIPT_DIR%"
if errorlevel 1 (
  echo.
  echo [ERROR] initialization failed.
  pause
  exit /b 1
)

echo.
echo [OK] initialization completed.
pause
exit /b 0
