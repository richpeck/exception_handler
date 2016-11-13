module ExceptionHandler
  class Exception 

    # => Include individual elements
    # => Only required if no db present (no ActiveRecord)
    if !ExceptionHandler.config.try(:db)
      include ActiveModel::Model
      include ActiveModel::Validations
    end

    ##################################
    ##################################

    ####################
    #      Table       #
    ####################

        # Schema
        ###################
        # Users removed in this version
        # class_name      @exception.class.name
        # status          ActionDispatch::ExceptionWrapper.new(@request.env, @exception).status_code
        # message         @exception.message
        # trace           @exception.backtrace.join("\n")
        # target_url      @request.url
        # referer_url     @request.referer
        # params          @request.params.inspect
        # user_agent      @request.user_agent
        # created_at
        # updated_at

      # => Table is called "errors"
      # => Dev needs to use migration to create db
      if ExceptionHandler.config.try(:db)
        def self.table_name
          ExceptionHandler.config.db
        end
      end

    ##################################
    ##################################

      ####################
      #     Options      #
      ####################

      # => Email
      # => after_initialize invoked after .new method called
      # => Should have been after_create but user may not save
      after_initialize Proc.new { |e| ExceptionHandler::ExceptionMailer.new_exception(e).deliver } if ExceptionHandler.config.try(:email) && ExceptionHandler.config.email.is_a?(String)

      # => Attributes
      attr_accessor :request, :klass, :class_name, :status, :details, :message, :trace, :target_url, :referer_url, :params, :user_agent

      # => Validations
      validates :klass, exclusion:    { in: [ActionController::RoutingError, AbstractController::ActionNotFound, ActiveRecord::RecordNotFound], message: "%{value}" }, if: "referrer.blank?"
      validates :user_agent, format:  { without: Regexp.new( ExceptionHandler::BOTS.join("|"), Regexp::IGNORECASE ) }

    ##################################
    ##################################

      ####################################
      # Exception
      ####################################

      # => Exception (virtual)
      def exception
        request.env['action_dispatch.exception']
      end

      # => Class Name
      def class_name=(class_name)
        exception.class.name
      end

      def klass
        exception.class
      end

      # => Description
      def description
        I18n.with_options scope: [:exception], message: message do |i18n|
          i18n.t response, default: status
        end
      end

      # => Message
      def message
        exception.message
      end

      # => Trace
      def trace
        exception.backtrace.join("\n")
      end

      ####################################
      # Request
      ####################################

      # => Target URL
      def target_url
        request.url
      end

      # => Referrer URL
      def referrer
        request.referer
      end

      # => Params
      def params
        request.params.inspect
      end

      # => User Agent
      def user_agent
        request.user_agent
      end

      ####################################
      # Other
      ####################################

      # => Status code (404, 500 etc)
      def status
        ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code.to_s
      end

      # => Server Response ("Not Found" etc)
      def response
        ActionDispatch::ExceptionWrapper.rescue_responses[exception.class.name]
      end

    ##################################
    ##################################

  end
end
