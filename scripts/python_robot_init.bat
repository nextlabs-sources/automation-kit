setlocal EnableDelayedExpansion
For /f "delims== tokens=2" %%a in ('findstr python_path config.txt') do (set PYTHONPATH=%%a)
for %%i in ("%~dp0..") do set "PROJECTBASE_DIR=%%~fi"
echo Project base directory is at: %PROJECTBASE_DIR%
set "VENV_DIR=%PROJECTBASE_DIR%\pythonenv"

if not "%PYTHONPATH%" == "" goto PythonOK

echo Please set the python install folder location in the python_path variable in config.txt
goto end

:PythonOK

python -m venv %VENV_DIR%
echo Virtual environment created

call %VENV_DIR%\Scripts\activate.bat

python -m pip install --upgrade pip
python -m pip install -r %PROJECTBASE_DIR%\scripts\requirements.txt
python -m pip install -r %PROJECTBASE_DIR%\scripts\lib_requirements.txt

:end
