function fun(){
	
	var config = {
			appUrl : 'https://testURL.in'
	}
	var env = karate.env;
	karate.log("Command Line input",env);
	
	if(env=='reqres'){
		config.appUrl = 'https://reqres.in';
	}else if(env=='gorestgo'){
		config.appUrl = 'https://gorest.co.in';
	}

	return config;
}