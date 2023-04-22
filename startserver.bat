:: if you're using the Don't Starve Together Dedicated Server thingy, the below line will be different.

c:\steamcmd\steamcmd.exe +login anonymous +app_update 343050 +quit

@ echo OFF

:: shut up echo

:: set the below variable 'main' to wherever your server's cluster folder is installed. don't use quotation marks yet!

set main=C:\Users\My Username\Documents\Klei\DoNotStarveTogether

:: it's also important there's no space between the variable name, the '=' sign and the first character. batch is funky.
