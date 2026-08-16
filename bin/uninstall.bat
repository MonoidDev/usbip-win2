@echo off

SET HWID=ROOT\USBIP_WIN2\UDE
set APPDIR=C:\Program Files\USBip

"%APPDIR%\devnode.exe" remove %HWID% root
rem alternative command since Windows 11, version 21H2
rem pnputil.exe /remove-device /deviceid %HWID% /subtree

rem Windows 10, version 1809 (Windows Server 2019) only, must be executed before the removal of the driver packages
"%APPDIR%\devnode.exe" filter remove upper USB\ROOT_HUB30 usbip2_filter

rem WARNING: use %%P and %%~nxP if you run this command in a .bat file
FOR /f %%P IN ('findstr /M /L /Q:u "usbip2_filter usbip2_ude" C:\WINDOWS\INF\oem*.inf') DO pnputil.exe /delete-driver %%~nxP /uninstall

rd /S /Q "%APPDIR%"
