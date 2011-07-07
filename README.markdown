ChromeXBMC
==========

ChromeXBMC is a Chrome Extension to remotely control XBMC using the JSON-RPC interface.

Setup
-----
Select options from the extension menu or by right-cliking the XBMC icon.
Enter the details for the XBMC webserver. You will find these on XBMC at System Settings => Network Settings => Services.

Known Bugs
----------
* If you have the screensaver setup to activate during a paused video, XBMC will crash when you attempt to resume the movie. There doesn't appear to be a workaround for this. So don't do it.
* TV Shows / Movies played from the "Recently Added" window will not display in the extension. I believe this has something to do with them not appearing in a playlist. Playing through all over means (including the "Recently Added" submenu) works fine.