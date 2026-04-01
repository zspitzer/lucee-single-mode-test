<cfscript>
// LDEV-6223: Test WebSocket connection on this host WITHOUT calling websocketInfo() first.
// This validates that the init ordering works correctly for multi-context setups.

writeOutput( "=== WebSocket Multi-Context Test (host1) ===" & chr( 10 ) );

try {
	if ( !structKeyExists( getFunctionList(), "CreateWebSocketClient" ) ) {
		throw( message="CreateWebSocketClient not available - websocket-client extension not installed", type="TestSetupError" );
	}

	// Connect to websocket on THIS host — do NOT call websocketInfo() first
	wsUrl = "ws://#cgi.http_host#/ws/TestListener";
	writeOutput( "Connecting to: #wsUrl#" & chr( 10 ) );

	clientListener = new WebSocketClientListener();
	ws = CreateWebSocketClient( wsUrl, clientListener );
	writeOutput( "Connected" & chr( 10 ) );

	sleep( 500 );

	testMsg = "hello from #cgi.http_host# at #now()#";
	ws.sendText( testMsg );
	writeOutput( "Sent: #testMsg#" & chr( 10 ) );

	sleep( 500 );

	ws.disconnect();
	sleep( 500 );

	received = clientListener.getMessages();
	writeOutput( chr( 10 ) & "=== Received ===" & chr( 10 ) );
	for ( msg in received ) {
		writeOutput( "  - #msg#" & chr( 10 ) );
	}

	errors = [];

	hasConnected = false;
	for ( msg in received ) {
		if ( msg == "CONNECTED" ) { hasConnected = true; break; }
	}
	if ( !hasConnected ) arrayAppend( errors, "No CONNECTED message (onOpen failed)" );

	hasEcho = false;
	expectedEcho = "ECHO:" & testMsg;
	for ( msg in received ) {
		if ( msg == expectedEcho ) { hasEcho = true; break; }
	}
	if ( !hasEcho ) arrayAppend( errors, "No ECHO message (onMessage failed)" );

	if ( arrayLen( errors ) ) {
		writeOutput( chr( 10 ) & "FAILED:" & chr( 10 ) );
		for ( err in errors ) {
			writeOutput( "  - #err#" & chr( 10 ) );
		}
		cfheader( statuscode=500, statustext="Test Failed" );
	}
	else {
		writeOutput( chr( 10 ) & "SUCCESS: WebSocket working on #cgi.http_host#" & chr( 10 ) );
	}
}
catch ( any e ) {
	writeOutput( "FAILED:" & chr( 10 ) );
	writeOutput( e.stacktrace );
	cfheader( statuscode=500, statustext="Test Failed" );
}
</cfscript>
