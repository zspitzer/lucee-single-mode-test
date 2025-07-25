<cfoutput>
	rendered at #now()#.
	#cgi.request_url#
	WebRoot: #expandPath("{web-root-directory}")#
	WebContextHash: #expandPath("{web-context-hash}")#
	ContextId: #getPageContext().getConfig().getIdentification().getId()#
</cfoutput>
<cfcache>
	<cfoutput>
		cached at #now()#.
		#cgi.request_url#
		WebRoot: #expandPath("{web-root-directory}")#
		WebContextHash: #expandPath("{web-context-hash}")#
		ContextId: #getPageContext().getConfig().getIdentification().getId()#
	</cfoutput>
</cfcache>

