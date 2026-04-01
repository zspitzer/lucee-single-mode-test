component hint="Simple WebSocket listener for multi-context testing (LDEV-6223)" {

	function onOpen( wsClient ) {
		wsClient.send( "CONNECTED" );
	}

	function onMessage( wsClient, message ) {
		wsClient.send( "ECHO:" & message );
	}

	function onClose( wsClient, reasonPhrase ) {
	}

}
