component {
	this.name="one";
	this.mappings["/regular"] = getDirectoryFromPath(getCurrentTemplatePath()) & "regularMapping";

	this.componentPaths = [
		getDirectoryFromPath(getCurrentTemplatePath()) & "compMapping"
	];
}