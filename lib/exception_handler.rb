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

	#Config
	#https://github.com/thoughtbot/paperclip/blob/523bd46c768226893f23889079a7aa9c73b57d68/lib/paperclip/railtie.rb#L13
	mattr_accessor :config
	@@config = ExceptionHandler::Config.defaults.deep_merge({}) #-> instance of defaults invoked with @@config, edited with deep_merge

	#Exception Handler
	class Exceptions < Rails::Engine
		#Keep helpers in your engine
		#http://guides.rubyonrails.org/engines.html#inside-an-engine
		#http://stackoverflow.com/questions/31877839/accessing-helpers-from-the-parent-app-in-an-isolated-rails-engine
		#use main_app to call "main app" helpers etc http://stackoverflow.com/a/9178022/1143732 + http://edgeapi.rubyonrails.org/classes/Rails/Engine.html#class-Rails::Engine-label-Using+Engine-27s+routes+outside+Engine
		isolate_namespace ExceptionHandler

		#Stylesheet
		config.assets.precompile += %w(exception_handler/error.css) 

		#Hook
		initializer "exception_handler.configure_rails_initialization" do |app|
			app.config.middleware.use "ExceptionHandler::Message" unless ExceptionHandler.config[:db] == false #Parser
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Pages
		end

	end
end