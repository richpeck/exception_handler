module ExceptionHandler
  class Exception #-> https://www.netguru.co/blog/service-objects-in-rails-will-help
    attr_reader :exception, :request, :message, :class

    def initialize request
      @request   = request
      @exception = request.env['action_dispatch.exception']

      @class     = @exception.class
      @message   = @exception.message
    end

    def status
      ActionDispatch::ExceptionWrapper.new(@request.env, @exception).status_code
    end

    def response
      ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    end

  end
end