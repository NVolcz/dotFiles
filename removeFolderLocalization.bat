@echo off
setlocal enabledelayedexpansion

pushd "%systemdrive%\"

for /f "delims=" %%G in ('dir /a /b /s desktop.ini') do (
find /i "LocalizedResourceName=" "%%~G" >nul
if !errorlevel! == 0 (
takeown /f "%%~G" /a >nul
icacls "%%~G" /grant:r *S-1-5-32-544:F /q >nul
attrib -h -s "%%~G"
type "%%~G" | findstr /i /v /c:"LocalizedResourceName=" > "%%~G.new"
copy "%%~G" "%%~nxG.bak" >nul 2>&1
del /a "%%~G"
ren "%%~G.new" "%%~nxG"
attrib +h +s "%%~G.bak"
attrib +h +s "%%~G"
))

popd
pause & exit /b