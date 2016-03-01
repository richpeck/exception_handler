module ExceptionHandler
	module Parser
		class Data

      attr_reader :exception, :request, :controller, :user

			#Create
			class << self
				def create exception, request, controller

          @exception  = exception
          @request    = request
          @controller = controller

					#http://blog.habanerohq.com/post/16800611137/selectively-silence-activerecord-logging
					message = ""
					Rails.logger.silence do #-> stops Error.create from showing output
						ExceptionHandler::Error.create info do |error|
							message += "\n======================\n"
							message += "#{error.class_name}:\n"
							message += "\n#{error.message}\n"
							message += Rails.backtrace_cleaner.clean(error.trace.split("\n")).join("\n")
							message += "\n======================\n"
						end
					end
					Rails.logger.fatal message unless message.blank?

				end
			end

			private

			#User
			def user
				@controller.send(:current_user) if @controller.respond_to?(:current_user)
			end

			#Info
			def info
				info = {
					class_name: 	@exception.class.to_s,
					message: 		  @exception.message.to_s,
					trace: 			  @exception.backtrace.join("\n"),
					target_url: 	@request.url,
					referer_url: 	@request.referer,
					params: 		  @request.params.inspect,
					user_agent: 	@request.user_agent
				}
				if @user && @user.respond_to(:id)
					info[:usable_type] 	= @user.model_name.human
					info[:usable_id] 	  = @user.id
				end
				info
			end

		end
	end
end