@echo off
Setlocal EnableDelayedExpansion
REM Set the output file path
set "outputFile=C:\kworking\System\logs\getNetAdapters.txt"
REM Create the output file directory if it doesn't exist
mkdir "%outputFile%\.." > nul 2>&1
REM Clear the output file if it already exists
Break > %outputfile%
Rem set cleanup to have a replacement value for older versions of windows.
Set wired=Ethernet
Set wireless=Wi-Fi
REM Find active network adapters
for /f "skip=3 tokens=2,4" %%a in ('netsh interface show interface ^| findstr /v "Disconnected"') do (
	REM This for loop cleans up differences from older versions of Windows.
	set adapter="%%b"
	for /f "delims=" %%h in ('echo %%b ^| findstr "Embedded NIC Local Area"') do (
		call set adapter=!adapter:%%b=%wired%!
	)
		for /f "delims=" %%h in ('echo %%b ^| findstr "Wireless"') do (
		call set adapter=!adapter:%%b=%wireless%!
	)
	REM Append the active adapter name to the output file and add commas.
	for /f "delims=" %%W in (!adapter!) do (
		set adapter="%%W,"
	)
	echo|set /p=!adapter!>> "%outputFile%"
)
Rem Read the output file into adapter variable
For /f "delims=" %%X in (%outputfile%) do (set adapter=%%X)
REM takes the full string and removes the last comma. Writing the to output file.
If "%adapter:~-1%"=="," echo|set /p=%adapter:~0,-1% > "%outputfile%"