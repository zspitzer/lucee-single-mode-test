component {
	this.name="two";
	this.mappings["/mapModel"] = getDirectoryFromPath(getCurrentTemplatePath()) & "model";

	this.componentPaths = [
		getDirectoryFromPath(getCurrentTemplatePath()) & "model"
	];
}