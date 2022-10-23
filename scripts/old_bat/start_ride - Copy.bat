@ECHO OFF

rem ---------------------------------------------------------------------------
rem Start script for ride
rem You must have wxPython 2.8.12.1 installed to use ride
rem ---------------------------------------------------------------------------

rem goto start

setlocal EnableDelayedExpansion

set "START_DIR=%CD%"
set "CURRENT_DIR=%~dp0"
set CURRENT_DIR=%CURRENT_DIR:~0,-1%

cd %CURRENT_DIR%\..
set "PROJECTBASE_DIR=%CD%"
cd %START_DIR%

if exist "%PROJECTBASE_DIR%\pythonenv" goto gotPythonEnvHome
echo Pythonn robot environment is not set up
echo Please run python_robot_init.bat first
goto end

:gotPythonEnvHome

echo project base directory is %PROJECTBASE_DIR%
set "PYTHONHOME=%PROJECTBASE_DIR%\pythonenv"
echo %PYTHONHOME%
set "PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%"
echo %PATH%
set "PYTHONPATH=%PROJECTBASE_DIR%\resources\Control Center"

rem:start
rem cd ..\pythonenv\Scripts
rem start "pythonw.exe" ride.py

echo Starting ride
start "pythonw.exe" "%PYTHONHOME%\Scripts\ride.py" "%PROJECTBASE_DIR%\testsuite"

:end
