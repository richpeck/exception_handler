###########################################

#Core Dependencies
require "action_dispatch"

#Gem Files
versions = %w(version parser config)
for version in versions do
	require "exception_handler/#{version}"
end

###########################################

module ExceptionHandler

	#Exception Handler
	class Exceptions < Rails::Engine
		initializer "exception_handler.configure_rails_initialization" do |app|
			app.config.middleware.use "ExceptionHandler::Message" unless ExceptionHandler.config.db == false #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end
	end

	####################
	#      Config      #
	####################

	#Ref http://robots.thoughtbot.com/mygem-configure-block
	mattr_accessor :config, :table

	#Vars
	@@config ||= Config.new

	#Block (for initializer)
	def self.setup
		yield(config) if block_given?
	end

end