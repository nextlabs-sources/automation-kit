@ECHO OFF

rem ---------------------------------------------------------------------------
rem Script for running test cases
rem You need to have jre (>=1.7) installed in your system and java in your PATH
rem ---------------------------------------------------------------------------

setlocal EnableDelayedExpansion

for %%i in ("%~dp0..") do set "PROJECTBASE_DIR=%%~fi"

if exist "%PROJECTBASE_DIR%\pythonenv" goto gotPythonEnvHome
echo Python robot environment is not set up
echo Please run python_robot_init.bat first
goto end

:gotPythonEnvHome

set "VENV_DIR=%PROJECTBASE_DIR%\pythonenv"
set "PATH=%PATH%;%VENV_DIR%\Scripts;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\"

set "OUTPUT_DIR=%PROJECTBASE_DIR%\results"
if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

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

call %VENV_DIR%\Scripts\activate.bat

rem Execute the command

python driver_setup.py
python -m robot.run --outputdir "%OUTPUT_DIR%\%today%" --variable DATA_DIR:"%PROJECTBASE_DIR%\testdata\Control Center" --variable LIB_DIR:"%PROJECTBASE_DIR%\scripts\custom libraries" --variable VAR_DIR:"%PROJECTBASE_DIR%\variables\Control Center" --variable RES_DIR:"%PROJECTBASE_DIR%\resources\Control Center" %CMD_LINE_ARGS% "%PROJECTBASE_DIR%\testsuite\01__Console"

:end