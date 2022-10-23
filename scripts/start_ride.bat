rem @ECHO OFF

rem ---------------------------------------------------------------------------
rem Start script for ride
rem You must have wxPython installed to use ride
rem ---------------------------------------------------------------------------

setlocal EnableDelayedExpansion

for %%i in ("%~dp0..") do set "PROJECTBASE_DIR=%%~fi"
echo Project base directory is at: %PROJECTBASE_DIR%

if exist "%PROJECTBASE_DIR%\pythonenv" goto gotPythonEnvHome
echo Python robot environment is not set up
echo Please run python_robot_init.bat first
goto end

:gotPythonEnvHome

set "VENV_DIR=%PROJECTBASE_DIR%\pythonenv"
set "PATH=%PATH%;%VENV_DIR%\Scripts;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\"

call %VENV_DIR%\Scripts\activate.bat

echo Starting ride
python driver_setup.py
pythonw "%VENV_DIR%\Scripts\ride.py" "%PROJECTBASE_DIR%\testsuite"

:end