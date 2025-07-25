Listing all Tomcat contexts
<cfscript>
	ctx = new contexts();
	ctxs = ctx.getContexts();
</cfscript>
<cfloop array=#ctxs# item="c">
	<cfoutput>
```
#serializeJSON(var=c,compact=false)#
```
	</cfoutput>
</cfloop>