<!--- LDEV-5534 - Test actual cfform tag rendering --->
<cfform name="testform" action="##">
	<cfinput type="text" name="testfield" value="hello">
</cfform>
<cfoutput>cfform rendered OK</cfoutput>
