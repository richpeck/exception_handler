module ExceptionHandler
	module Parser
		class Ignore

			#Init
			def initialize(exception, request)
				@exception, @request = exception, request
			end

			#Matches?
			def match?
				return true if errors.include?(@exception.class) && @request.referer.blank?
				return true if @request.user_agent =~ bots
			end

			private

			#Has to be instance vars for env to handle ActionController::RoutingError constant etc

			#Errors
			def errors #-> http://ruby-doc.org/core-2.2.0/Array.html#class-Array-label-Creating+Arrays
				[ActionController::RoutingError, AbstractController::ActionNotFound, ActiveRecord::RecordNotFound]
			end

			#Bots
			def bots
				Regexp.new %w(Baidu Gigabot Googlebot libwww-per lwp-trivial msnbot SiteUptime Slurp Wordpress ZIBB ZyBorg Yandex Jyxobot Huaweisymantecspider ApptusBot).join("|"), Regexp::IGNORECASE
			end

		end
	end
end