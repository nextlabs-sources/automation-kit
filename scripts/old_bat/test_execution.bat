@ECHO OFF

rem ---------------------------------------------------------------------------
rem To RUN test cases using tags
rem ---
rem ---------------------------------------------------------------------------

setlocal EnableDelayedExpansion

set "START_DIR=%CD%"
set "CURRENT_DIR=%~dp0"
set CURRENT_DIR=%CURRENT_DIR:~0,-1%

cd %CURRENT_DIR%\..
set "PROJECTBASE_DIR=%CD%"

call %PROJECTBASE_DIR%\scripts\run_tests_python.bat -i "PolicyModelUser" -i "PolicyModel" -i "Action" -i "Resource" -i "Subject" -i "Policy" -i "Deploy"

:end
