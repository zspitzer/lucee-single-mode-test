<cfoutput>
	rendered at #now()#.<br/>
	#cgi.request_url#<br/>
</cfoutput>
<cfcache>
	<cfoutput>
		cached at #now()#.<br/>
		#cgi.request_url#<br/>
	</cfoutput>
</cfcache>

