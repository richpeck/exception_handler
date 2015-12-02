module ExceptionHandler
	module Parser
		class Save

			#Init
			def initialize(exception, request, controller)
				@exception, @request, @controller = exception, request, controller
			end

			#Save
			def save
				ActiveRecord::Base.logger.silence do
					ExceptionHandler::Error.create(relevant_info)
				end
	 			log(relevant_info)
			end

			#Info
			def relevant_info(info = {})
				info[:class_name] 	= @exception.class.to_s
				info[:message] 		= @exception.to_s
				info[:trace] 		= @exception.backtrace.join("\n")
				info[:target_url] 	= @request.url
				info[:referer_url] 	= @request.referer
				info[:params] 		= @request.params.inspect
				info[:user_agent] 	= @request.user_agent
				if user
					info[:usable_type] 	= user[:type]
					info[:usable_id] 	= user[:id]
				end
				return info
			end

			#User
			def user(data = {})
				# => refer to Joe's if want to find admin / user
				if @controller.respond_to?(:current_user)
					user = @controller.send :current_user
					[:id].each do |field|
						data[:id] = user.send(field) 	if user.respond_to?(field)
						data[:type] = "User" 			if @controller.respond_to?("current_user")
					end
				end
				return data
			end

			#Log
			def log(info)
				message = "#{info[:class_name]} (#{info[:message]}):\n "
				message += Rails.backtrace_cleaner.clean(info[:trace].split("\n")).join("\n")
				Rails.logger.fatal(message)
			end

		end
	end
end