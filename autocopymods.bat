@echo OFF

echo V1 local mods to Dedicated Server Mod directory

pause

set mods=C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together\mods

:: change the 'server' variable to whereever your dedicated server tool is installed. i'm using steamcmd installed to my C:\ drive.

set server=C:\steamcmd\steamapps\common\Don't Starve Together Dedicated Server\mods

:: add mod directory names to the for loop depending on which one you're developing.

for %%a in (
    dst-002_CustomCmds
    ) do (
    if not exist "%server%\%%a" mkdir "%server%\%%a"
    
    xcopy /s /i "%mods%\%%a" "%server%\%%a" /y
)
 
pause

explorer "%server%"
 
exit

