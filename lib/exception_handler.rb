###########################################

require "action_dispatch"

require "exception_handler/version"
require "exception_handler/parser"

###########################################

module ExceptionHandler

	#Exception Handler
	class Exceptions < Rails::Engine
		initializer "exception_handler.configure_rails_initialization" do |app|
			app.config.middleware.use "ExceptionHandler::Message" #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end
	end

end