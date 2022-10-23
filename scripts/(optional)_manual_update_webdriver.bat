setlocal EnableDelayedExpansion
for %%i in ("%~dp0..") do set "PROJECTBASE_DIR=%%~fi"
echo Project base directory is at: %PROJECTBASE_DIR%
set "VENV_DIR=%PROJECTBASE_DIR%\pythonenv"
set "PATH=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\;%PATH%"

call %VENV_DIR%\Scripts\activate.bat

python driver_setup.py

deactivate

cmd /k