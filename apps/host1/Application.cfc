component {
	this.name="one";
	this.mappings["/regular"] = getDirectoryFromPath(getCurrentTemplatePath()) & "regularMapping";

	this.componentPaths = [
		getDirectoryFromPath(getCurrentTemplatePath()) & "compMapping"
	];

	function onError( required any exception, required string eventName ) {
		cfheader( name="Content-Type", value="text/plain" );
		writeOutput( "Error in #arguments.eventName#" & chr( 10 ) & chr( 10 ) );
		writeOutput( "Message: #arguments.exception.message#" & chr( 10 ) );
		writeOutput( "Detail: #arguments.exception.detail#" & chr( 10 ) & chr( 10 ) );
		writeOutput( "Stacktrace:" & chr( 10 ) );
		writeOutput( arguments.exception.stacktrace );
		abort;
	}
}