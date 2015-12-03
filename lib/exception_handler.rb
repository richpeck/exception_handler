###########################################

#Core Dependencies
require "action_dispatch"

#Libs
#http://stackoverflow.com/a/4528011/1143732
#https://github.com/jekyll/jekyll/blob/master/lib/jekyll.rb#L8
#def require_all(path)
#  glob = File.join(File.dirname(__FILE__), path, '**/*.rb')
#  Dir[glob].each do |f|
#    require f
#  end
#end

#http://stackoverflow.com/a/21693468/1143732
Dir.glob(File.join(File.dirname(__FILE__), "exception_handler", '**/*.rb'), &method(:require))

###########################################

module ExceptionHandler

	#Version
	autoload :VERSION, 'exception_handler/version'

	#Config
	#https://github.com/thoughtbot/paperclip/blob/523bd46c768226893f23889079a7aa9c73b57d68/lib/paperclip/railtie.rb#L13
	mattr_accessor :config
	@@config = ExceptionHandler::Config.defaults #-> instance of defaults invoked with @@config, merged with deep_merge

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
		config.assets.precompile += %w(exception_handler/error.css) 

		#Config
		@@config = ExceptionHandler.config

		#Hook
		initializer "exception_handler.configure_rails_initialization" do |app|
			
			#Options
			@@config.deep_merge!(app.config.exception_handler) if app.config.respond_to? :exception_handler

			#Middleware
			app.config.middleware.use ExceptionHandler::Parse if @@config[:db] # && ActiveRecord::Base.connection.table_exists?(:errors unless @@config[:db].blank?)  #DB
			app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #Controller
		end

	end
end