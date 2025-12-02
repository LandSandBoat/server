@echo off
REM =========================================
REM LandSandBoat Launcher Setup
REM Installs Python dependencies and launches GUI
REM =========================================

REM Check Python 3 availability
py -3 --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Python 3 is not installed or not in PATH.
    pause
    exit /b 1
)

REM Install required Python packages
echo Installing required Python packages...
py -3 -m pip install --upgrade pip
py -3 -m pip install psutil

REM Launch the GUI
echo Launching LandSandBoat Server Launcher...
start "" pyw "%~dp0launcher_gui.pyw"

REM Exit setup
exit /b 0