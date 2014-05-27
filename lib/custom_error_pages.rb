###########################################

require "action_dispatch"
require "custom_error_pages/version"

###########################################

module CustomErrorPages
	class Exceptions < Rails::Engine
		initializer "custom_error_pages.configure_rails_initialization" do |app|
			app.config.exceptions_app = ->(env) { CustomErrorPages::ExceptionController.action(:show).call(env) } #Error Pages
		end
	end
end