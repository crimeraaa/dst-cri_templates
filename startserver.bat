:: if you're using the Don't Starve Together Dedicated Server thingy, the below line will be different.

c:\steamcmd\steamcmd.exe +login anonymous +app_update 343050 +quit

@ echo OFF

:: ==========MOD SETUP===========

:: see the comment as the first line, this may be different.

set server=C:\steamcmd\steamapps\common\Don't Starve Together Dedicated Server

cd /D "%server%/bin"

:: for the following variable declarations: DON'T USE QUOTATION MARKS! We'll surround them with quotes later on.

set cluster=[[your cluster folder location]]

set modsetup=[[path to 'dedicated_server_mods_setup.lua' here]]

set modoverrides=[[path to your 'modoverrides.lua' file here]]

:: remove the '/s' parameter below if you're trying to overwrite a file within the same parent folder.

xcopy /s /i "%modsetup%" "%server%\mods" /y

xcopy /s /i "%modoverrides%" "%cluster%\Master\" /y

xcopy /s /i "%modoverrides%" "%cluster%\Caves\" /y

:: ==========START SERVER===========

:: stolen from thegreatmanagement#4508 :)

start "DST Master" dontstarve_dedicated_server_nullrenderer console_enabled -cluster My_Cluster_Foldername -shard Master

timeout 1

start "DST Caves" dontstarve_dedicated_server_nullrenderer console_enabled -cluster My_Cluster_Foldername -shard Caves
