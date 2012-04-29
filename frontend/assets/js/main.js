require(["order!vendor/jquery-1.7.2",
         "order!vendor/jquery-ui-1.8.19.custom.min",     
         "order!vendor/underscore-min",
         "order!vendor/underscore.string.min",
         "order!vendor/less-1.3.0.min",
         "order!vendor/haml",
         "order!vendor/backbone",
        // ZEPTO ERROR EN IE9 "order!vendor/zepto.min",
         "order!coffeejs/agent",
         "order!coffeejs/app"
         ], function($) {
	

	    //This function is called when scripts/helper/util.js is loaded.
	    //If util.js calls define(), then this function is not fired until
	    //util's dependencies have loaded, and the util argument will hold
	    //the module value for "helper/util".
	    
		app();
	
	
	});

function app() {
	InitCoffeeScriptAgentView();
}

