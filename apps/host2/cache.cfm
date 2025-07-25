<cfoutput>
	rendered at #now()#.<br/>
	#cgi.request_url#<br/>
	#expandPath("{web-root-directory}")#<br>
</cfoutput>
<cfcache>
	<cfoutput>
		cached at #now()#.<br/>
		#cgi.request_url#<br/>
		#expandPath("{web-root-directory}")#<br>
	</cfoutput>
</cfcache>

