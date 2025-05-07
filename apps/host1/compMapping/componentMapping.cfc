component {
	variables.name = "testOne";

	function hello(){
		return [
			variables.name,
			getCurrentTemplatePath()
		];
	}
}