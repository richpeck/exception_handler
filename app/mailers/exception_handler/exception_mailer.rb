module ExceptionHandler
  class ExceptionMailer < ActionMailer::Base

      # Layout
      layout "mailer"

      # Defaults
      default from: 			    ExceptionHandler.config.email
      default template_path: 	"exception_handler/mailers" # => http://stackoverflow.com/a/18579046/1143732
      
      def self.should_notify?(exception)
        defaults = ExceptionHandler.config.exceptions[:all]
        options  = ExceptionHandler.config.exceptions[exception.status] || defaults

        case options[:deliver]
        when TrueClass, FalseClass then options[:deliver]
        when Proc then options[:deliver].call(exception)
        when nil then true # Deliver exceptions by default
        else raise ArgumentError.new("Unexpected config value for exceptions[#{exception.status}]: #{options[:deliver].inspect}")
        end
      end

      def new_exception e
      	@exception = e
        mail to: ExceptionHandler.config.email
        Rails.logger.info "Exception Sent To → #{ExceptionHandler.config.email}"
      end
  end
end
