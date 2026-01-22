<cfscript>
	// LDEV-5534 - Form Tags extension mapping test in single mode
	// Test if /lucee/formtag-form.cfm is accessible via internal request
	// https://luceeserver.atlassian.net/browse/LDEV-5534

	echo( "## LDEV-5534 Form Tags Extension Mapping Test#chr( 10 )##chr( 10 )#" );
	systemOutput( "## LDEV-5534 Form Tags Extension Mapping Test", true );

	// Report installed form extension version
	formExtId = "FAD67145-E3AE-30F8-1C11A6CCF544F0B7";
	qryExt = extensionList().filter( function( row ) { return row.id == formExtId; } );
	if ( qryExt.recordCount ) {
		echo( "Form Extension v#qryExt.version# installed#chr( 10 )#" );
		systemOutput( "Form Extension v#qryExt.version# installed", true );
	} else {
		echo( ":x: Form Extension NOT installed#chr( 10 )#" );
		systemOutput( "Form Extension NOT installed", true );
		header statusCode=500 statusText="Form Extension Not Installed";
	}

	try {
		result = internalRequest( template="/lucee/formtag-form.cfm" );
		statusCode = result.status_code;
		echo( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode##chr( 10 )#" );
		systemOutput( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode#", true );

		if ( statusCode == 200 ) {
			echo( ":white_check_mark: formtag-form.cfm accessible#chr( 10 )#" );
			systemOutput( "PASS: formtag-form.cfm accessible", true );
		} else {
			echo( ":x: formtag-form.cfm returned HTTP #statusCode##chr( 10 )#" );
			systemOutput( "FAIL: formtag-form.cfm returned HTTP #statusCode#", true );
			header statusCode=500 statusText="Form Tags Extension Test Failed";
		}
	} catch ( any e ) {
		echo( ":x: #e.type#: #e.message##chr( 10 )#" );
		systemOutput( "FAIL: #e.type#: #e.message#", true );
		header statusCode=500 statusText="Form Tags Extension Test Failed";
	}
</cfscript>
