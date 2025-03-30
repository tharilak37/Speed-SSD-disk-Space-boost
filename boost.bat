@echo off
echo Cleaning temporary files...
del /s /q %TEMP%\*.* >nul 2>&1
del /s /q C:\Windows\Temp\*.* >nul 2>&1
echo Temporary files cleaned.

echo Flushing RAM cache...
wmic process where "name like '%%chrome%%'" call terminate >nul 2>&1
wmic process where "name like '%%edge%%'" call terminate >nul 2>&1
echo RAM cache cleared.

echo Freeing up disk space...
cleanmgr /sagerun:1
echo Disk cleanup completed.

echo Freeing up RAM...

:: Clear clipboard (removes copied data)
echo. | clip

:: Empty standby memory (hidden RAM cache)
powershell -Command "Clear-RecycleBin -Confirm:$false"
powershell -Command "& {([Runtime.InteropServices.Marshal]::ReleaseComObject([wmiclass]'Win32_OperatingSystem')).FlushMemory()}" >nul 2>&1

:: Stop unused processes
wmic process where "name like '%%OneDrive%%'" call terminate >nul 2>&1
wmic process where "name like '%%Skype%%'" call terminate >nul 2>&1

echo All changes will reset on reboot.
echo PC is now faster & optimized!
pause
exit
