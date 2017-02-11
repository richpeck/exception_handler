module ExceptionHandler

  ############################################################
  ############################################################

    # => Search Bots
    # => Used in "Exception" class
    BOTS = %w(Baidu Gigabot Googlebot libwww-per lwp-trivial msnbot SiteUptime Slurp Wordpress ZIBB ZyBorg Yandex Jyxobot Huaweisymantecspider ApptusBot)

    # => Attributes
    # => Determine schema etc
    ATTRS = %i(class_name status message trace target referrer params user_agent)

  ############################################################
  ############################################################

    # => Class (inheritance dependent on whether db option is available)
    self::Exception = Class.new (ExceptionHandler.config.try(:db) ? ActiveRecord::Base : Object) do

      # => Include individual elements
      # => Only required if no db present (no ActiveRecord)
      if ExceptionHandler.config.try(:db)

        # => Set Attrs
        def initialize attributes={}
            super
            ATTRS.each do |type|
              self[type] = eval type.to_s
            end
        end

      else

        # => AciveModel
        include ActiveModel::Model
        include ActiveModel::Validations

        # => Callback Extension
        extend ActiveModel::Callbacks
        define_model_callbacks :initialize, only: :after

        # => Initialize
        # => http://api.rubyonrails.org/classes/ActiveModel/Callbacks.html
        # => http://stackoverflow.com/a/17682228/1143732
        def initialize attributes={}
          super
          run_callbacks :initialize do
            # => Needed for after_initialize
          end
        end

      end

      ##################################
      ##################################

      ####################
      #      Table       #
      ####################

          # Schema
          ###################
          # class_name      @exception.class.name
          # status          ActionDispatch::ExceptionWrapper.new(@request.env, @exception).status_code
          # message         @exception.message
          # trace           @exception.backtrace.join("\n")
          # target          @request.url
          # referer         @request.referer
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
        after_initialize Proc.new { |e| ExceptionHandler::ExceptionMailer.new_exception(e).deliver } if ExceptionHandler.config.try(:email).try(:is_a?, String)

        # => Attributes
        attr_accessor :request, :klass, :exception, :description
        attr_accessor *ATTRS unless ExceptionHandler.config.try(:db)

        # => Validations
        validates :klass, exclusion:    { in: [ActionController::RoutingError, AbstractController::ActionNotFound, ActiveRecord::RecordNotFound], message: "%{value}" }, if: "referer.blank?"
        validates :user_agent, format:  { without: Regexp.new( BOTS.join("|"), Regexp::IGNORECASE ) }

      ##################################
      ##################################

        ####################################
        # Virtual
        ####################################

          # => Klass
          # => Used for validation (needs to be cleaned up in 0.7.0)
          def klass
            exception.class
          end

          # => Exception (virtual)
          def exception
            request.env['action_dispatch.exception']
          end

          # => Description
          def description
            I18n.with_options scope: [:exception_handler], message: message, status: status do |i18n|
              i18n.t response, default: Rack::Utils::HTTP_STATUS_CODES[status] || status
            end
          end

        ####################################
        # Exception
        ####################################

          # => Class Name
          def class_name
            exception.class.name
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
          def target
            request.url
          end

          # => Referrer URL
          def referer
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
            ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code
          end

          # => Server Response ("Not Found" etc)
          def response
            ActionDispatch::ExceptionWrapper.rescue_responses[class_name]
          end

      ##################################
      ##################################

    end
  end

  ############################################################
  ############################################################
