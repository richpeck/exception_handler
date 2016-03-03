module ExceptionHandler
  class ExceptionController < ApplicationController

    #Response
    #http://www.justinweiss.com/articles/respond-to-without-all-the-pain/
    respond_to :html, :xml, :json

    #Layout
    layout :layout

    #Helpers
    helper ExceptionHandler::Engine.helpers      #-> HELPERS http://stackoverflow.com/questions/9809787/why-is-my-rails-mountable-engine-not-loading-helper-methods-correctly
    include Rails.application.routes.url_helpers #-> ROUTES http://stackoverflow.com/a/6074911/1143732

    ####################
    #      Action      #
    ####################

  	#Show
    #Amend responses in tests
    def show
      @exception = ExceptionHandler::Exception.new request #-> Service Object
      # Need to test validity of JSON responses etc
    end

    ####################
    #   Dependencies   #
    ####################

    protected

    # Status declarations moved to "show" w/ service object
    # Details moved to "View Helper"

    ####################
    #      Layout      #
    ####################

    private

    #Layout
    def layout
      (/^(5[0-9]{2})$/ !~ @exception.code) ? (ExceptionHandler.config.layouts["404"] || nil) : ExceptionHandler.config.layouts["500"] #-> inherits ApplicationController layout (nil means it will use standard layout from ApplicationController)    
    end

    ####################

  end
end
