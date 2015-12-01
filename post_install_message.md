########################################################################################
##  _____                   _   _               _   _                 _ _             ##
## |  ___|                 | | (_)             | | | |               | | |            ##
## | |____  _____ ___ _ __ | |_ _  ___  _ __   | |_| | __ _ _ __   __| | | ___ _ __   ##
## |  __\ \/ / __/ _ \ '_ \| __| |/ _ \| '_ \  |  _  |/ _` | '_ \ / _` | |/ _ \ '__|  ##
## | |___>  < (_|  __/ |_) | |_| | (_) | | | | | | | | (_| | | | | (_| | |  __/ |     ##
## \____/_/\_\___\___| .__/ \__|_|\___/|_| |_| \_| |_/\__,_|_| |_|\__,_|_|\___|_|     ## 
##                   | |                                                              ##
##                  |_|                                                               ##
########################################################################################

IMPORTANT -
**IF UPGRADING***
**DELETE INITIALIZER (config/initializers/exception_handler.rb)**

We've changed the initialization process for ExceptionHandler.

The initializer has been replaced with /config/application.rb
options:

#config/application.rb
config.exception_handler = {
	db:   	false, #-> defaults to :errors if true, else use :table_name
	email: 	false, #-> need to integrate
	social: {
	    :twitter 	=> 	'frontlineutils',
	    :facebook 	=> 	'frontline.utilities',
	    :linkedin 	=> 	'frontline-utilities',
	    :youtube 	=>	'frontlineutils',
	    :fusion 	=> 	'frontlineutils',
	},
	layouts: {
	    '400' => nil,
	    '500' => 'exception'
	},
}

If you've made any changes to your initializer,
you MUST DELETE it, replacing the options with
those in config/application.rb.

More info on the ExceptionHandler github page:
http://github.com/richpeck/exception_handler

Thank you & enjoy!!