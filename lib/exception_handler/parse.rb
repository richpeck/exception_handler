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
			controller 	= env['action_controller.instance']
			ignore 		= ExceptionHandler::Parser::Ignore.new(exception, request).match?

			ExceptionHandler::Parser::Data.new(exception, request, controller).save unless ignore
			raise exception
		end

	end
end
