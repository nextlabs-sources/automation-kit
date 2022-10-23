@ECHO OFF

rem ---------------------------------------------------------------------------
rem Script for installing robot python libraries specified in lib_requirements.txt
rem ---------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set "START_DIR=%CD%"
set "CURRENT_DIR=%~dp0"
set CURRENT_DIR=%CURRENT_DIR:~0,-1%

cd %CURRENT_DIR%\..
set "PROJECTBASE_DIR=%CD%"
echo %PROJECTBASE_DIR%
cd %START_DIR%

if exist "%PROJECTBASE_DIR%\pythonenv" goto gotPythonEnvHome
echo Pythonn robot environment is not set up
echo Please run python_robot_init.bat first
goto end

:gotPythonEnvHome

set "PYTHONHOME=%PROJECTBASE_DIR%\pythonenv"
set "PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%"
cd ..\pythonenv\Scripts
call activate.bat

"pip.exe" install -r "%PROJECTBASE_DIR%\scripts\lib_requirements.txt"

:end
