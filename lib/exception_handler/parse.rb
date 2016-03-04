module ExceptionHandler
  class Parse

  # Init
  def initialize(app)
    @app = app
  end

  #Exception
  def call(env)
    @app.call(env)

    rescue Exception => exception 
      request 	= ActionDispatch::Request.new(env)
      controller 	= request.env['action_controller.instance']
      ignore 		= ExceptionHandler::Parser::Ignore.new(exception, request).match?

      ExceptionHandler::Parser::Data.create exception, request, controller unless ignore
      raise exception
    end

  end
end