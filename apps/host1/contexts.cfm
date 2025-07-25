Listing all Tomcat contexts
<cfscript>
	ctx = new contexts();
	ctxs = ctx.getContexts();
	factories = ctx.getFactories();
</cfscript>
<cfloop array=#ctxs# item="c">
	<cfoutput>
```
#serializeJSON(var=c,compact=false)#
```
	</cfoutput>
</cfloop>

Listing all Lucee Contexts
<cfloop array=#factories# item="f">
	<cfoutput>
```
#serializeJSON(var=f,compact=false)#
```
	</cfoutput>
</cfloop>


