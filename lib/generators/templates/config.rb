#Exception Handler
###
#You can add different settings using this block
#Use the docs at http://github.com/richpeck/exception_handler for info
###
ExceptionHandler.setup do |config|

	#DB - 
	#Options = false / true
	config.db = false

	#Email -
	#Default = false / true
	#config.email = 

	#Social
	config.social = {
		twitter: 	"http://twitter.com/frontlineutils",
		facebook: 	"https://facebook.com/frontline.utilities",
		linkedin: 	"https://linkedin.com/company/frontline-utilities",
		youtube: 	"https://youtube.com/user/frontlineutils",
		fusion: 	"http://frontlinefusion.com/frontlineutils"
	}

end