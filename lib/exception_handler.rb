###########################################

#Core Dependencies
require "action_dispatch"

#Libs
#http://stackoverflow.com/a/4528011/1143732
#http://stackoverflow.com/a/21693468/1143732
#https://github.com/jekyll/jekyll/blob/master/lib/jekyll.rb#L8
Dir.glob(File.join(File.dirname(__FILE__), "exception_handler", '**/*.rb'), &method(:require))

###########################################

module ExceptionHandler

	#Version
	autoload :VERSION, 'exception_handler/version'

	#Config
	#Invoke instance of config -- loads defaults
	mattr_accessor :config

	# Don't have prefix method return anything.
    # This will keep Rails Engine from generating all table prefixes with the engines name
    # http://stackoverflow.com/questions/19435214/rails-mountable-engine-with-isolate-namespace-but-without-prefixed-namespace-on
    def self.table_name_prefix
    	#No prefix
    end

	#Exception Handler
	class Exceptions < Rails::Engine
		#Keep helpers in your engine
		#http://guides.rubyonrails.org/engines.html#inside-an-engine
		#http://stackoverflow.com/questions/31877839/accessing-helpers-from-the-parent-app-in-an-isolated-rails-engine
		#use main_app to call "main app" helpers etc http://stackoverflow.com/a/9178022/1143732 + http://edgeapi.rubyonrails.org/classes/Rails/Engine.html#class-Rails::Engine-label-Using+Engine-27s+routes+outside+Engine
		isolate_namespace ExceptionHandler

		#Stylesheet
		%w(error.css close.png alert.png home.png connect/facebook.png connect/fusion.png connect/linkedin.png connect/youtube.png connect/twitter.png).each { |a| config.assets.precompile << "exception_handler/#{a.to_s}" }

		#Hook
		initializer "exception_handler.configure_rails_initialization" do |app|
			
			#Options
			ExceptionHandler.config = ExceptionHandler::Config.new(app.config.respond_to?(:exception_handler) ? app.config.exception_handler : nil)

			#Middleware
			app.config.middleware.use ExceptionHandler::Parse if ExceptionHandler.config.db # && ActiveRecord::Base.connection.table_exists?(:errors unless @@config[:db].blank?)  #DB
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Controller	
		end

	end
end