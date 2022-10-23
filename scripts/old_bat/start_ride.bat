rem @ECHO OFF

rem ---------------------------------------------------------------------------
rem Start script for ride
rem You must have wxPython 2.8.12.1 installed to use ride
rem ---------------------------------------------------------------------------

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

set "PYTHONHOME=%PROJECTBASE_DIR%\pythonenv"
set "PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%"
set "PYTHONPATH=%PROJECTBASE_DIR%\pythonlib;%PROJECTBASE_DIR%\resources\Control Center;%PROJECTBASE_DIR%\libdoc"

echo Starting ride
echo this is my python home %PYTHONHOME%
rem start "" "pythonw.exe" "%PYTHONHOME%\Scripts\ride.py" "%PROJECTBASE_DIR%\testsuite"
"python.exe" "%PYTHONHOME%\Scripts\ride.py" "%PROJECTBASE_DIR%\testsuite"

:end
