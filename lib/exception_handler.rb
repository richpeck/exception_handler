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
		initializer "exception_handler.configure_rails_initialization" do |app|
			app.config.middleware.use "ExceptionHandler::Message" unless ExceptionHandler.config.db == false #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end
	end

	####################
	#      Config      #
	####################

	class << self

		#Ref http://robots.thoughtbot.com/mygem-configure-block
		#Can call ExceptionHandler.config.x
		mattr_accessor :config

	end

	#Block (for initializer)
	def self.setup
		self.config ||= Config.new
		yield(config) if block_given?
	end

end