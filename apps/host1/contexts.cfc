component {
	function getContexts(){
		var mbs = createObject("java", "java.lang.management.ManagementFactory").getPlatformMBeanServer();
		var objectNamePattern = createObject("java", "javax.management.ObjectName").init("Catalina:type=Manager,*");
		var mbeans = mbs.queryNames(objectNamePattern, javacast("null", ""));
		var contexts = [];
		var iterator = mbeans.iterator();
		while (iterator.hasNext()) {
			var objectName = iterator.next();
			var host = objectName.getKeyProperty("host");
			var path = objectName.getKeyProperty("context");

			// The context path for the ROOT application is often "/" or ""
			if (path == '/') {
				path = 'ROOT'; // Or handle as appropriate
			} else if (path == '') {
				path = 'ROOT'; // Or handle as appropriate
			} else {
				// Remove leading slash if it exists, for cleaner display
				if (len(path) > 0 && left(path, 1) == '/') {
					path = right(path, len(path) - 1);
				}
			}

			var docBase = "";
			try {
				docBase = mbs.getAttribute(objectName, "docBase");
			} catch (any e) {
				// docBase might not be available for all Manager MBeans or in all Tomcat versions
			}

			arrayAppend(contexts, {
				host = host,
				path = path,
			//	docBase = docBase, 
				objectName = objectName.toString()
			});
		}
		return contexts;
	}
}