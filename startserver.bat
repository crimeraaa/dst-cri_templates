:: if you're using the Don't Starve Together Dedicated Server thingy, the below line will be different.

c:\steamcmd\steamcmd.exe +login anonymous +app_update 343050 +quit

@ echo OFF

:: ==========MOD SETUP===========

:: see the comment as the first line, this may be different.

set server=C:\steamcmd\steamapps\common\Don't Starve Together Dedicated Server

cd /D "%server%/bin"

:: for the following variable declarations: DON'T USE QUOTATION MARKS! We'll surround them with quotes later on.

:: also remove the < and > characters when actually filling it in. don't add a space after the = sign.

set cluster=<full path to your cluster folder>

:: example: set cluster=C\Users\My Username\Documents\Klei\DoNotStarveTogether\Crimeraaas_Testing_Server

set modsetup=<full path to 'dedicated_server_mods_setup.lua'>

:: example: set modsetup=C\Users\My Username\Documents\Klei\DoNotStarveTogether\Dedicated Server Settings\dedicated_server_mods_setup.lua

set modoverrides=<full path to 'modoverrides.lua'>

:: example: set modoverrides=C\Users\My Username\Documents\Klei\DoNotStarveTogether\Crimeraaas_Testing_Server\modoverrides.lua

:: remove the '/s' parameter below if you're trying to overwrite a file within the same parent folder.

xcopy /s /i "%modsetup%" "%server%\mods" /y

:: my modoverrides for my testing server is in the same parent folder, i'll have to omit the /s.

xcopy /s /i "%modoverrides%" "%cluster%\Master\" /y

xcopy /s /i "%modoverrides%" "%cluster%\Caves\" /y

:: ==========START SERVER===========

:: stolen from thegreatmanagement#4508 :)

start "DST Master" dontstarve_dedicated_server_nullrenderer console_enabled -cluster My_Cluster_Foldername -shard Master

timeout 1

start "DST Caves" dontstarve_dedicated_server_nullrenderer console_enabled -cluster My_Cluster_Foldername -shard Caves
