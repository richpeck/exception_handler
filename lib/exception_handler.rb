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
			app.config.middleware.use "ExceptionHandler::Message" if config.db #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end
	end

	#Config
	#Ref http://robots.thoughtbot.com/mygem-configure-block
	class << self
		attr_accessor :config
	end

	#Block (for initializer)
	def self.setup
		self.config ||= Config.new
		yield(config) if block_given?
	end
end