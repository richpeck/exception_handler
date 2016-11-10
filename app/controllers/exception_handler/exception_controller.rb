module ExceptionHandler
  class ExceptionController < ApplicationController

    # => Response
    # => http://www.justinweiss.com/articles/respond-to-without-all-the-pain/
    respond_to :html, :xml, :json

    ##################################
    ##################################

    # => Definitions
    # => Exception model (tied to DB)
    before_action { |e| @exception = ExceptionHandler::Exception.new request: e.request }
    before_action { @exception.save if @exception.valid? && ExceptionHandler.config.try(:db) }

    # => Routes
    # => Removes need for "main_app" prefix in routes
    # => http://stackoverflow.com/a/40251516/1143732
    helper Rails.application.routes.url_helpers

    # => Layout
    # => Layouts only 400 / 500 because they are the only error responses (300 is redirect)
    # => http://guides.rubyonrails.org/layouts_and_rendering.html#the-status-option
    # => Layout proc kills inheritance, needs to be method for now
    layout :layout

    ####################
    #      Action      #
    ####################

    def show
      respond_with @exception, status: @exception.status
    end

    ##################################
    ##################################

    private

    def layout
      ExceptionHandler.config.layouts[ @exception.status[0] + "00" ]
    end

  end
end
