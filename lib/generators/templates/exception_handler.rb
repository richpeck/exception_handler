#Exception Handler
###
#You can add different settings using this block
#Use the docs at http://github.com/richpeck/exception_handler for info
###
ExceptionHandler.setup do |config|
	#DB - 
	#Default = false / true ("errors")
	#Options = [string] = sets db name (if use true, default is "errors")
	config.db = true
	#Email -
	#Default = false / true
	#config.email = 
end