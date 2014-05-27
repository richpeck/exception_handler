###########################################

require "action_dispatch"

require "custom_error_pages/version"
require "custom_error_pages/parser"

###########################################

module CustomErrorPages

	#Exception Handler
	class Exceptions < Rails::Engine
		initializer "custom_error_pages.configure_rails_initialization" do |app|
			app.config.middleware.use "CustomErrorPages::Message" #Parser
			app.config.exceptions_app = ->(env) { CustomErrorPages::ExceptionController.action(:show).call(env) } #Pages
		end
	end

end