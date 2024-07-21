@echo off
setlocal enabledelayedexpansion

:: Specify the path to the 3DMigoto's Executable (including the executable name)
  :: Example: set "migotoFullPath=/home/Nya/Anime Mods/ZZMI/ZZZ3dmLoader.exe"
set "migotoFullPath=<insert full path to your 3DMigoto's executable>"
:: Specify the path to the game directory (NOT including the executable name)
  :: Example: set "gameDirectory=/home/Nya/Anime Games/Zenless Zone Zero
set "gameDirectory=<insert the path to the game directory>"



:: You shouldn't need to modify anything below this.



rem Extract directory path from the full path (without trailing backslash)
for %%i in ("%migotoFullPath%") do set "migotoPath=%%~dpi"
set "migotoPath=%migotoPath:~0,-1%"

rem Extract the executable name from the full path
for %%i in ("%migotoFullPath%") do set "migotoExecutable=%%~nxi"

rem Change directory to migotoPath
cd /d "%migotoPath%"

rem Start the 3DMigoto executable and wait for its completion
call "%migotoExecutable%"


:: Below is the code for launching the game


rem  Change to the game directory
cd /d "%gameDirectory%"

rem Capture all the command line arguments
set input=%*

rem Find position of the first occurrence of .exe
set exePos=0
set len=0

:search_loop
set char=!input:~%exePos%,1!
if "!char!"=="" goto not_found
if "!input:~%exePos%,4!"==".exe" (
    set /a len=exePos+4
    goto found_position
)
set /a exePos+=1
goto search_loop

:not_found
echo No .exe found
goto end

:found_position
rem Extract everything starting from the .exe position
set output=!input:~%exePos%!

rem Extract backward to get the full .exe name and arguments
set exePos=%exePos%
:backward_search
set prevChar=!input:~%exePos%,1!
if "!prevChar!"==" " goto end_backward_search
if %exePos% LEQ 0 goto end_backward_search
set /a exePos-=1
goto backward_search

:end_backward_search
set /a exePos+=1
set output=!input:~%exePos%!%output:~4%

rem Start the game with the extracted executable name and arguments
start "" %output%

:end
endlocal
