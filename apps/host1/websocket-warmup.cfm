<cfscript>
// LDEV-6223 warmup: triggers lazy init of websocket endpoint via websocketInfo()
try {
	info = websocketInfo();
	writeOutput( "websocketInfo() OK on #cgi.http_host# — mapping: #info.mapping ?: 'not set'#" & chr( 10 ) );
}
catch ( any e ) {
	writeOutput( "websocketInfo() FAILED on #cgi.http_host#: #e.message#" & chr( 10 ) );
}
</cfscript>
