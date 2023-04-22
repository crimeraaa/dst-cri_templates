@echo OFF

:: This file will let you copy local mods from the V1 folder to a dedi server's mods folder, which allows the dedi server to use those.

:: =========PATH DECLARATIONS============

:: do note you shouldn't put quotation marks yet! windows batch scripting is funky.

set mods=C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together\mods

set steam=C:\steamcmd\steamapps\common\Don't Starve Together Dedicated Server\mods

:: change the value for 'steam' if you installed steamcmd.exe elsewhere or using the original DST server thingy.

:: =============USER INPUT===============

:a

echo Moving V1 Mods to Dedicated Server

set /p in="Mod Directory Name under V1 Mods: "

if %in%==exit exit

if %in%==n exit

set from=%mods%\%in%\

set out=%steam%\%in%\

if not exist "%from%" goto c

if not exist "%out%" mkdir "%out%"

xcopy /s /i "%from%" "%out%" /y

echo Repeat?

:b 

set /p more="Would you like to go again? Yes (y) or No (n): "
 
if %more%==y goto a
 
if %more%==n goto d
 
:c

echo '%in%' does not exist. Did you type it correctly? 

goto b

:d
 
explorer "%steam%"
 
exit

