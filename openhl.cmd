@echo off
setlocal
set "ROOT=%~dp0"
node "%ROOT%bin\openhl.js" %*
exit /b %ERRORLEVEL%
