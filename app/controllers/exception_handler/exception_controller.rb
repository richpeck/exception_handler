module ExceptionHandler
  class ExceptionController < ApplicationController

    #Response
    #http://www.justinweiss.com/articles/respond-to-without-all-the-pain/
    respond_to :html, :xml, :json

  	#Dependencies
  	before_action :status

    #Layout
    layout :layout_status

    #Helpers
    helper ExceptionHandler::Engine.helpers  #-> HELPERS http://stackoverflow.com/questions/9809787/why-is-my-rails-mountable-engine-not-loading-helper-methods-correctly
    include Rails.application.routes.url_helpers #-> ROUTES http://stackoverflow.com/a/6074911/1143732

    ####################
    #      Action      #
    ####################

  	#Show
    def show
      # Amend responses in tests
    end

    ####################
    #   Dependencies   #
    ####################

    protected

    #Info
    def status
      @exception  = request.env['action_dispatch.exception']
      @status     = ActionDispatch::ExceptionWrapper.new(request.env, @exception).status_code
      @response   = ActionDispatch::ExceptionWrapper.rescue_responses[@exception.class.name]
    end

    # Details moved to "View Helper"

    ####################
    #      Layout      #
    ####################

    private

    #Layout
    def layout_status
      case  @status
        when 404
          ExceptionHandler.config.layouts["404"] || nil #-> inherits ApplicationController layout (nil means it will use standard layout from ApplicationController)
        else
          ExceptionHandler.config.layouts["500"]        #-> should pull default if none sepecified
      end     
    end

    ####################

  end
end
