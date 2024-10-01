@echo off
Set "AccountResults=C:\kworking\system\AccountResults.txt"
Break >%AccountResults%
Rem pulls user accounts and lockout status arranged in an array. If lockout = true, it echos the account name into AccountResults.txt
For /F "skip=1 tokens=1,2*" %%h in ('wmic useraccount get name^,lockout ^| findstr /v "Admin root Template Guest"') do (If %%h==TRUE (
	Echo|set /p="%%i,">> %AccountResults%
	net user %%i /active:yes
))
Rem Read the output file into var variable
For /f "delims=" %%X in (%AccountResults%) do (set var=%%X)
REM takes the full string, reads the last character, and removes the last comma. Writes to AccountResults.txt.
If "%var:~-1%"=="," echo|set /p=%var:~0,-1% > %AccountResults%