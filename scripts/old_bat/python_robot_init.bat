setlocal EnableDelayedExpansion

set "START_DIR=%CD%"
set "CURRENT_DIR=%~dp0"
set CURRENT_DIR=%CURRENT_DIR:~0,-1%

if not "%PYTHONHOME%" == "" goto gotPythonHome

echo The PYTHONHOME environment variable is not defined correctly
echo This environment variable is needed to run this program
echo Please install python and set the PYTHONHOME environment before running this program
goto end

:gotPythonHome
set "PATH=%PYTHONHOME%;%PYTHONHOME%\Scripts;%PATH%"

if exist "%PYTHONHOME%\Scripts\pip.exe" goto okPip
echo The pip python executable is not found
echo This python package is need to run this program
echo Maybe your python version is too old? You should user 2.7.9 or above
goto end
:okPip
pip install virtualenv

echo Set up python robot environment
cd %CURRENT_DIR%\..
set "PROJECTBASE_DIR=%CD%"
cd %START_DIR%

"virtualenv.exe" --system-site-packages --always-copy "%PROJECTBASE_DIR%\pythonenv"
set "PYTHONHOME=%PROJECTBASE_DIR%\pythonenv"
cd ..\pythonenv\Scripts
call activate.bat

cd %PROJECTBASE_DIR%
echo Install required python packages to virtualenv
"pip.exe" install -r "%PROJECTBASE_DIR%\scripts\requirements.txt"

:end
