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
  #Invoke instance of config (ExceptionHandler.config) -- loads defaults -- can merge through class
  mattr_accessor :config

  #Default (has to init so is available in all areas)
  @@config = "" #-> should initialize class & then append in initializer

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

    #Tests (generates dummy Rails app)
    #http://stackoverflow.com/q/32082637/1143732 (ref in question)
    config.generators do |g|
      g.test_framework :rspec
    end

    #Assets
    config.assets.precompile << %w(exception_handler/**)

    #Config
    config.before_initialize do |app|
      ExceptionHandler.config = ExceptionHandler::Config.new app.config.try(:exception_handler) #-> Var
    end

    #Boot order:
    #http://api.rubyonrails.org/classes/Rails/Application.html#class-Rails::Application-label-Booting+process
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

    #Hook
    #Needs to fire before better_errors (for dev)
    initializer :exception_handler, before: "better_errors.configure_rails_initialization" do |app| #-> "before" ref - http://blog.carbonfive.com/2011/02/25/configure-your-gem-the-rails-way-with-railtie/ && http://apidock.com/rails/Rails/Initializable/Initializer/before - should degrade gracefully

      #Action
      app.config.middleware.use ExceptionHandler::Parse if ExceptionHandler.config.try(:db) #-> DB
      app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionController.action(:show).call(env) } #-> Controller

      #Dev
      #Logic needed after initialize (app data)
      app.config.consider_all_requests_local = false if Rails.env.development? and ExceptionHandler.config.try(:dev)
    end

  end
end

###########################################