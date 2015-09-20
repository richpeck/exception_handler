###########################################

#Core Dependencies
require "action_dispatch"

#Gem Files
libs = %w(version parser config)
for lib in libs do
	require "exception_handler/#{lib}"
end

###########################################

module ExceptionHandler

	#Exception Handler
	class Exceptions < Rails::Engine

		#Stylesheet
		config.assets.precompile += %w(exception_handler/error.css) 

		#Parser
		initializer "exception_handler.configure_rails_initialization" do |app|
			app.config.middleware.use "ExceptionHandler::Message" unless ExceptionHandler.config.db == false #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end

	end

	####################
	#      Config      #
	####################

	mattr_accessor :config, :table

	#Vars
	@@config ||= Config.new

	#Block (for initializer)
	def self.setup
		yield(config) if block_given?
	end
end