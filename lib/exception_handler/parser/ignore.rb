module ExceptionHandler
	module Parser
		class Ignore

			#Options
			mattr_accessor :errors, :bots
			#@@errors 	= [ActionController::RoutingError, AbstractController::ActionNotFound, ActiveRecord::RecordNotFound]
			@@bots 		= Regexp.new %w(Baidu Gigabot Googlebot libwww-per lwp-trivial msnbot SiteUptime Slurp Wordpress ZIBB ZyBorg Yandex Jyxobot Huaweisymantecspider ApptusBot).join("|"), Regexp::IGNORECASE

			def initialize(exception, request)
				@exception, @request = exception, request
			end

			def match?
				#return true if @@errors.include?(@exception.class) && @request.referer.blank?
				return true if @request.user_agent =~ bots
			end

		end
	end
end