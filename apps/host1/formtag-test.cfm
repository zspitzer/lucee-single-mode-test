<cfscript>
	// LDEV-5534 / LDEV-6073 - Form Tags extension mapping test in single mode
	// Test if /lucee/formtag-form.cfm is accessible via internal request
	// LDEV-6073: Test that it remains accessible AFTER a config reload
	// https://luceeserver.atlassian.net/browse/LDEV-5534
	// https://luceeserver.atlassian.net/browse/LDEV-6073

	adminPassword = "admin";

	echo( "## LDEV-5534 / LDEV-6073 Form Tags Extension Mapping Test#chr( 10 )##chr( 10 )#" );
	systemOutput( "## LDEV-5534 / LDEV-6073 Form Tags Extension Mapping Test", true );

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

	// Test 1: Initial access (LDEV-5534)
	echo( "#chr( 10 )###Test 1: Initial access (LDEV-5534)#chr( 10 )#" );
	systemOutput( "#### Test 1: Initial access (LDEV-5534)", true );

	try {
		result = internalRequest( template="/lucee/formtag-form.cfm" );
		statusCode = result.status_code;
		echo( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode##chr( 10 )#" );
		systemOutput( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode#", true );

		if ( statusCode == 200 ) {
			echo( ":white_check_mark: Test 1 PASS: formtag-form.cfm accessible#chr( 10 )#" );
			systemOutput( "Test 1 PASS: formtag-form.cfm accessible", true );
		} else {
			echo( ":x: Test 1 FAIL: formtag-form.cfm returned HTTP #statusCode##chr( 10 )#" );
			systemOutput( "Test 1 FAIL: formtag-form.cfm returned HTTP #statusCode#", true );
			header statusCode=500 statusText="Form Tags Extension Test Failed";
		}
	} catch ( any e ) {
		echo( ":x: Test 1 FAIL: #e.type#: #e.message##chr( 10 )#" );
		systemOutput( "Test 1 FAIL: #e.type#: #e.message#", true );
		header statusCode=500 statusText="Form Tags Extension Test Failed";
	}

	// Test 2: After config reload (LDEV-6073)
	// Trigger a config reload by updating a harmless setting
	echo( "#chr( 10 )##### Test 2: After config reload (LDEV-6073)#chr( 10 )#" );
	systemOutput( "#### Test 2: After config reload (LDEV-6073)", true );

	try {
		// Trigger config reload by toggling a setting
		admin action="updateCompilerSettings"
			type="server"
			password="#adminPassword#"
			dotNotationUpperCase="true";

		echo( "Config reload triggered via cfadmin#chr( 10 )#" );
		systemOutput( "Config reload triggered via cfadmin", true );

		// Now test again - this is where LDEV-6073 would fail
		result = internalRequest( template="/lucee/formtag-form.cfm" );
		statusCode = result.status_code;
		echo( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode##chr( 10 )#" );
		systemOutput( "internalRequest /lucee/formtag-form.cfm: HTTP #statusCode#", true );

		if ( statusCode == 200 ) {
			echo( ":white_check_mark: Test 2 PASS: formtag-form.cfm accessible after reload#chr( 10 )#" );
			systemOutput( "Test 2 PASS: formtag-form.cfm accessible after reload", true );
		} else {
			echo( ":x: Test 2 FAIL: formtag-form.cfm returned HTTP #statusCode# after reload#chr( 10 )#" );
			systemOutput( "Test 2 FAIL: formtag-form.cfm returned HTTP #statusCode# after reload", true );
			header statusCode=500 statusText="Form Tags Extension Test Failed After Reload";
		}
	} catch ( any e ) {
		echo( ":x: Test 2 FAIL: #e.type#: #e.message##chr( 10 )#" );
		systemOutput( "Test 2 FAIL: #e.type#: #e.message#", true );
		header statusCode=500 statusText="Form Tags Extension Test Failed After Reload";
	}

	echo( "#chr( 10 )### All tests completed#chr( 10 )#" );
	systemOutput( "## All tests completed", true );
</cfscript>
