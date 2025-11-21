<cfscript>
// File Access Security Test
// Tests that file access restrictions work correctly in single-context mode

logger( "" );
logger( "=== File Access Security Test (LDEV-5931) ===" );
logger( "" );

webroot = expandPath( "/" );
outsideFile = "/tmp/test-outside.txt";
testsFailed = 0;

// Get configured file access mode from SecurityManager directly
try {
	sm = getPageContext().getConfig().getSecurityManager();
	fileAccessValue = sm.getAccess( sm.TYPE_FILE );
	// 0=none, 1=local, 2=all
	fileAccessMode = fileAccessValue == 0 ? "none" : ( fileAccessValue == 1 ? "local" : "all" );
} catch ( any e ) {
	fileAccessMode = "all"; // default if can't get security manager
}

logger( "Configured file access mode: " & fileAccessMode );
logger( "Web root: " & webroot );
logger( "" );

// Test 1: Write file in webroot
try {
	testFile = webroot & "test-write.txt";
	fileWrite( testFile, "test content" );

	if ( fileAccessMode == "none" ) {
		logger( ":x: TEST 1 FAILED: Should NOT be able to write to webroot with mode='none': " & testFile );
		testsFailed++;
	} else {
		logger( ":white_check_mark: TEST 1 PASSED: Can write file in webroot with mode='" & fileAccessMode & "'" );
	}
} catch ( any e ) {
	if ( fileAccessMode == "none" ) {
		logger( ":white_check_mark: TEST 1 PASSED: Correctly blocked write to webroot with mode='none'" );
		logger( "  Error: " & e.message );
	} else {
		logger( ":x: TEST 1 FAILED: Should be able to write to webroot with mode='" & fileAccessMode & "'" );
		logger( "  Error: " & e.message );
		logger( "  Detail: " & e.detail );
		testsFailed++;
	}
}

logger( "" );

// Test 2: Read file in webroot
try {
	if ( isDefined( "testFile" ) && fileExists( testFile ) ) {
		content = fileRead( testFile );

		if ( fileAccessMode == "none" ) {
			logger( ":x: TEST 2 FAILED: Should NOT be able to read from webroot with mode='none'" );
			testsFailed++;
		} else {
			logger( ":white_check_mark: TEST 2 PASSED: Can read file in webroot with mode='" & fileAccessMode & "'" );
		}
	} else {
		logger( ":white_check_mark: TEST 2 SKIPPED: No test file created (expected with mode='none')" );
	}
} catch ( any e ) {
	if ( fileAccessMode == "none" ) {
		logger( ":white_check_mark: TEST 2 PASSED: Correctly blocked read from webroot with mode='none'" );
		logger( "  Error: " & e.message );
	} else {
		logger( ":x: TEST 2 FAILED: Should be able to read from webroot with mode='" & fileAccessMode & "'" );
		logger( "  Error: " & e.message );
		testsFailed++;
	}
}

logger( "" );

// Test 3: Try to write outside webroot
try {
	fileWrite( outsideFile, "test content" );

	if ( fileAccessMode == "all" ) {
		logger( ":white_check_mark: TEST 3 PASSED: Can write outside webroot with mode='all': " & outsideFile );
	} else {
		logger( ":x: TEST 3 FAILED: Should NOT be able to write outside webroot with mode='" & fileAccessMode & "': " & outsideFile );
		testsFailed++;
	}
} catch ( any e ) {
	if ( fileAccessMode == "all" ) {
		logger( ":x: TEST 3 FAILED: Should be able to write outside webroot with mode='all'" );
		logger( "  Error: " & e.message );
		testsFailed++;
	} else {
		logger( ":white_check_mark: TEST 3 PASSED: Correctly blocked access outside webroot with mode='" & fileAccessMode & "'" );
		logger( "  Error: " & e.message );
	}
}

logger( "" );
logger( "=== File Access Security Test Complete ===" );
logger( "Tests Failed: " & testsFailed );
logger( "" );
</cfscript>
