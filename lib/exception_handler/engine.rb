module ExceptionHandler
  class Engine < Rails::Engine

    # => Rails default MIME types:
    # => http://apidock.com/rails/ActionController/MimeResponds/InstanceMethods/respond_to#14-Rails-defined-Mime-Types

    #########################################################
    #########################################################
    #########################################################
    #########################################################

      # => Wraps helpers in ExceptionHandler module
      # => http://guides.rubyonrails.org/engines.html#inside-an-engine
      # => http://stackoverflow.com/questions/31877839/accessing-helpers-from-the-parent-app-in-an-isolated-rails-engine
      isolate_namespace ExceptionHandler

      # => Tests
      config.generators do |g|
        g.test_framework :rspec
      end

      # => Assets
      # => For Sprockets 4, had to include link_tree in exception_handler.css
      config.assets.precompile << %w(exception_handler.css)

    #########################################################
    #########################################################

      # => Config
      # => Builds lib/exception_handler/config.rb
      config.before_initialize do |app|
        ExceptionHandler.config ||= ExceptionHandler::Config.new config.try(:exception_handler)
      end

      # => Custom Exceptions
      # => Allows users to define custom exceptions & assign to HTTP status code
      config.before_initialize do |app|
        ExceptionHandler.config.try(:custom_exceptions).try(:each) do |exception,response|
          config.action_dispatch.rescue_responses[exception] = response
        end
      end

    #########################################################
    #########################################################

      # => Middleware
      # => This should be config.before_initialize but because ActiveRecord is not initialized, cannot check for table
      initializer :exception_handler, before: "better_errors.configure_rails_initialization" do |app|
        app.config.exceptions_app = ->(env) { ExceptionHandler::ExceptionsController.action(:show).call(env) }
        app.config.consider_all_requests_local = !ExceptionHandler.config.try(:dev) if Rails.env.development?
      end

      # => Migrations
      # => This has to be kept in an initializer (to access app)
      # => https://blog.pivotal.io/labs/labs/leave-your-migrations-in-your-rails-engines
      initializer :migration_paths do |app|
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path if ExceptionHandler.config.try(:db)
        end
      end

    #########################################################
    #########################################################
    #########################################################
    #########################################################

  end
end
