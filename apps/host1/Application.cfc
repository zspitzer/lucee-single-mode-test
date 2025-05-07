component {
	this.name="one";
	this.mappings["/mapModel"] = getDirectoryFromPath(getCurrentTemplatePath()) & "model";

	this.componentPaths = [{
		"componentMapping": getDirectoryFromPath(getCurrentTemplatePath()) & "model",
	}];
}