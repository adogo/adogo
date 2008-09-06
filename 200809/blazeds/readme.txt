This project requires BlazeDS to work as shown at the 
September Adogo meeting.  This example shows how an alternative
UI (using HTML and JS) can be substituted for the Flex UI created
in April 2008's Adogo meeting.  Configuration files can be found 
in the Adogo SVN repository @:

http://svn.adogo.us/200804/RemotingAndMessaging/BlazeDSConfig/

This solution also uses the BlazeDs turnkey solution, so if you are
running BlazeDS is any other server context, be sure to updated 
"script.js" with the correct URL on line 20.

Please keep in mind, to avoid cross-site request issues, the entire 
contents of this folder are intended to be deployed as a web 
application in the same domain as the BlazeDS context(s) being referred
to on line 20 of "script.js".

If you'd like to download BlazeDS, it can be found at
http://opensource.adobe.com/wiki/display/blazeds/BlazeDS.

On a final note, please note that this example is intended to be a simple 
and procedural which is easy to demonstrate.    