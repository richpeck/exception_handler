module ExceptionHandler
  class Exception #-> https://www.netguru.co/blog/service-objects-in-rails-will-help
    attr_reader :exception, :request, :class, :message

    ######################

    def initialize request
      @request   = request
      @exception = request.env['action_dispatch.exception']

      @class     = @exception.class
      @message   = @exception.message
    end

    ######################

    # Status code (404, 500 etc)
    def code
      ActionDispatch::ExceptionWrapper.new(@request.env, @exception).status_code
    end

    # Server Response ("Not Found" etc)
    def response
      ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    end

    ######################

    alias_method :status, :code #-> http://stackoverflow.com/a/11848832/1143732 (has to be below methods)

    ######################

  end
end