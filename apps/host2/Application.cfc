component {
	this.name="two";
	this.mappings["/regular"] = getDirectoryFromPath(getCurrentTemplatePath()) & "regularMapping";

	this.componentPaths = [
		getDirectoryFromPath(getCurrentTemplatePath()) & "compMapping"
	];
}