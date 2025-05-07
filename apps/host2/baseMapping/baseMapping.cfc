component {
	variables.name = "testTwo";

	function hello(){
		return [
			variables.name,
			getCurrentTemplatePath()
		];
	}
}