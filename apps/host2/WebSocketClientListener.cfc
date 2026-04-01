component {

	variables.messages = [];

	function onOpen( wsClient ) {
	}

	function onMessage( wsClient, message ) {
		arrayAppend( variables.messages, message );
	}

	function onClose( wsClient, closeReason ) {
	}

	function onError( wsClient, error ) {
	}

	array function getMessages() {
		return variables.messages;
	}

}
