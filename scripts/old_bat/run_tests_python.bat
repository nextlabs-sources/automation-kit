@ECHO OFF

rem ---------------------------------------------------------------------------
rem Script for running test cases
rem You need to have jre (>=1.7) installed in your system and java in your PATH
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

set "OUTPUT_DIR=%PROJECTBASE_DIR%\results"
if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

rem Add resources and pythonlib folder to PYTHONPATH
set "PYTHONPATH=%PROJECTBASE_DIR%\resources\Control Center;%PROJECTBASE_DIR%\pythonlib"

for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do set %%x
::pad 0 if month, day, hour or minute is only 1 digit
set Month=0%Month%
set Month=%Month:~-2%
set Day=0%Day%
set Day=%Day:~-2%
set Hour=0%Hour%
set Hour=%Hour:~-2%
set Minute=0%Minute%
set Minute=%Minute:~-2%
set today=%Year%%Month%%Day%%Hour%%Minute%

rem Get remaining unshifted command line arguments and save them in the
set CMD_LINE_ARGS=

:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs

rem Execute the command
Python driver_setup.py
python -m robot.run --outputdir "%OUTPUT_DIR%\%today%" --variable DATA_DIR:"%PROJECTBASE_DIR%\testdata\Control Center" --variable LIB_DIR:"%PROJECTBASE_DIR%\scripts\custom libraries" --variable VAR_DIR:"%PROJECTBASE_DIR%\variables\Control Center" %CMD_LINE_ARGS% "%PROJECTBASE_DIR%\testsuite\Control Center"
