component {
	this.name="one";
	this.mappings["/mapModel"] = getDirectoryFromPath(getCurrentTemplatePath()) & "model";

	this.componentPaths = [
		getDirectoryFromPath(getCurrentTemplatePath()) & "model"
	];
}