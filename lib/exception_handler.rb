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

  #Config
  #Invoke instance of config (ExceptionHandler.config) -- loads defaults
  mattr_accessor :config

  # Class methods
  class << self
    # Don't have prefix method return anything.
    # This will keep Rails Engine from generating all table prefixes with the engines name
    # http://stackoverflow.com/questions/19435214/rails-mountable-engine-with-isolate-namespace-but-without-prefixed-namespace-on
    def table_name_prefix
      #No prefix
    end
  end

  #########################

  #Exception Handler
  class Engine < Rails::Engine
    #Keep helpers in your engine
    #http://guides.rubyonrails.org/engines.html#inside-an-engine
    #http://stackoverflow.com/questions/31877839/accessing-helpers-from-the-parent-app-in-an-isolated-rails-engine
    #use main_app to call "main app" helpers etc http://stackoverflow.com/a/9178022/1143732 + http://edgeapi.rubyonrails.org/classes/Rails/Engine.html#class-Rails::Engine-label-Using+Engine-27s+routes+outside+Engine
    isolate_namespace ExceptionHandler

    #Assets
    config.assets.precompile << %w(exception_handler/**)

    #Hook
    initializer :configure_rails_initialization do |app|

      #Has to be loaded after Rails app
      #Boot order:
      #1)  require "config/boot.rb" to setup load paths
      #2)  require railties and engines
      #3)  Define Rails.application as "class MyApp::Application < Rails::Application"
      #4)  Run config.before_configuration callbacks
      #5)  Load config/environments/ENV.rb
      #6)  Run config.before_initialize callbacks
      #7)  Run Railtie#initializer defined by railties, engines and application.
      #    One by one, each engine sets up its load paths, routes and runs its config/initializers/* files.
      #8)  Custom Railtie#initializers added by railties, engines and applications are executed
      #9)  Build the middleware stack and run to_prepare callbacks
      #10) Run config.before_eager_load and eager_load! if eager_load is true
      #11) Run config.after_initialize callbacks
      #http://api.rubyonrails.org/classes/Rails/Application.html#class-Rails::Application-label-Booting+process
      ExceptionHandler.config = ExceptionHandler::Config.new app.config.try(:exception_handler)

      app.config.middleware.use ExceptionHandler::Parse if ExceptionHandler.config.db 						            # Saves to DB
      app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } 	# Routes to Controller	
    end

    #Dev
    if Rails.env.development? #-> skip if not development env
      initializer :after_initialize do |app| #-> works except if better errors is on system
        app.config.consider_all_requests_local = false if ExceptionHandler.config.dev #-> dev "false" by default
      end
    end

  end

  #########################
end

###########################################