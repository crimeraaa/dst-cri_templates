@ echo OFF

:: make sure to change the variables' data to those specific to your device!

set /p opt="Start caves as well? (y/n): "

c:\steamcmd\steamcmd.exe +login anonymous +app_update 343050 +quit

:: userprofile is a predefined variable that refers to, for example for me: C:\Users\Crimeraaa

set main=%userprofile%\Documents\Klei\DoNotStarveTogether

set name=Crimeraaas_Testing_Server

set cluster=%main%\%name%

set setup=%main%\Dedicated Server Settings\dedicated_server_mods_setup.lua

set over=%cluster%\modoverrides.lua

set server=C:\steamcmd\steamapps\common\Don't Starve Together Dedicated Server

xcopy "%setup%" "%server%\mods" /y

xcopy "%over%" "%cluster%\Master\" /y

xcopy "%over%" "%cluster%\Caves\" /y

cd /D "%server%\bin"

start "DST Master" dontstarve_dedicated_server_nullrenderer console_enabled -cluster "%name%" -shard Master

timeout 1

if %opt%==y start "DST Caves" dontstarve_dedicated_server_nullrenderer console_enabled -cluster "%name%" -shard Caves

